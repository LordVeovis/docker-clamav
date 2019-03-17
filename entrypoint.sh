#!/bin/sh

set -e

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    case $MODE in
        av)
            echo 'Running in anvi-virus mode...'
            set -- /usr/sbin/clamd $@
            ;;
        updater)
            echo 'Running in updater mode...'
            set -- /usr/bin/freshclam -d -p "$CLAMAV_RUN/freshclam.pid" $@
            ;;
        *)
            set -- /bin/sh
            ;;
    esac
fi

if [ ! "$(ls -A /etc/clamav)" ]; then
    echo 'Extracting default conf in /etc/clamav'
    tar -xvjf /etc/_clamav.tar.bz2 /
fi

echo 'Configuring daemons for Docker...'
sed -i 's/^#\(Foreground \).*/\1yes/' /etc/clamav/freshclam.conf
sed -i 's/^#\(Foreground \).*/\1yes/' /etc/clamav/clamd.conf
sed -i 's/^#\(TCPSocket \)/\1/' /etc/clamav/clamd.conf
#sed -i 's/^#\(TCPAddr \).*/\10.0.0.0/' /etc/clamav/clamd.conf

if [ "$INITIAL_UPDATE" = "1" ] && [ ! "$(ls -A $CLAMAV_VAR_LIB)" ]; then
    echo 'Running first-time freshclam...'
    /usr/bin/freshclam -d
fi

exec su-exec clamav "$@"