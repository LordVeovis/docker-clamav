FROM alpine:3.9

ENV CLAMAV_VAR_LIB /var/lib/clamav
ENV CLAMAV_RUN /run/clamav

RUN set -xe; \
	apk add clamav su-exec; \
	install -d -o clamav -g clamav -m 755 /run/clamav; \
	sed -i 's/^#\(Foreground\)/\1/' /etc/clamav/freshclam.conf; \
	tar -cvjf /etc/_clamav.tar.bz2 /etc/clamav

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

VOLUME /etc/clamav
VOLUME $CLAMAV_VAR_LIB
