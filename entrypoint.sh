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
        milter)
            echo 'Running in milter mode...'
            set -- /usr/sbin/clamav-milter
            ;;
        *)
            set -- /bin/sh
            ;;
    esac
fi

if [ ! "$(ls -A $CLAMAV_ETC)" ]; then
    echo "Extracting default conf in $CLAMAV_ETC"
    tar -xvjf /etc/_clamav.tar.bz2 /
fi

echo 'Configuring daemons for Docker...'
sed -i 's/^#\(Foreground \).*/\1yes/' $CLAMAV_ETC/freshclam.conf
sed -i 's/^#\(Foreground \).*/\1yes/' $CLAMAV_ETC/clamd.conf
sed -i 's/^#\(Foreground \).*/\1yes/' $CLAMAV_ETC/clamav-milter.conf
sed -i 's/^#\(TCPSocket \)/\1/' $CLAMAV_ETC/clamd.conf
sed -i 's/^#\(MilterSocket inet:7357\).*/\1/' $CLAMAV_ETC/clamav-milter.conf
sed -i 's/^#\(ClamdSocket \).*/\1tcp:clamav:3310/' $CLAMAV_ETC/clamav-milter.conf

if [ "$INITIAL_UPDATE" = "1" ] && [ ! "$(ls -A $CLAMAV_VAR_LIB)" ]; then
    echo 'Running first-time freshclam...'
    /usr/bin/freshclam
fi

exec su-exec clamav "$@"