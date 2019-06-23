FROM alpine:3.10

ENV CLAMAV_ETC /etc/clamav
ENV CLAMAV_VAR_LIB /var/lib/clamav
ENV CLAMAV_RUN /run/clamav

RUN set -xe; \
	apk add clamav-daemon clamav-milter su-exec; \
	install -d -o clamav -g clamav -m 755 /run/clamav; \
	sed -i 's/^#\(Foreground\)/\1/' $CLAMAV_ETC/freshclam.conf; \
	sed -i 's/^#\(Foreground \).*/\1yes/' $CLAMAV_ETC/clamd.conf; \
	sed -i 's/^#\(Foreground \).*/\1yes/' $CLAMAV_ETC/clamav-milter.conf; \
	sed -i 's/^#\(TCPSocket \)/\1/' $CLAMAV_ETC/clamd.conf; \
	sed -i 's/^#\(MilterSocket inet:7357\).*/\1/' $CLAMAV_ETC/clamav-milter.conf; \
	sed -i 's/^#\(ClamdSocket \).*/\1tcp:clamav:3310/' $CLAMAV_ETC/clamav-milter.conf; \
	tar -cvjf /etc/_clamav.tar.bz2 etc/clamav

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

VOLUME $CLAMAV_ETC
VOLUME $CLAMAV_VAR_LIB

EXPOSE 3310 7357