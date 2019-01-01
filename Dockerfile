FROM alpine:3.8

RUN set -xe; \
	apk add clamav; \
	install -d -o clamav -g clamav -m 755 /run/clamav

RUN set -xe; \
	sed -i 's/^\(NotifyClamd\)/#\1/' /etc/clamav/freshclam.conf; \
	su -s /usr/bin/freshclam clamav

VOLUME /etc/clamav
VOLUME /var/lib/clamav
USER clamav
CMD ["/usr/sbin/clamd"]
