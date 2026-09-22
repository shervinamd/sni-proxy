FROM alpine:latest AS builder
ARG XRAY_VERSION=$XRAY_VERSION
RUN wget -c https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip \
  && unzip -d xray Xray-linux-64.zip \
  && rm -f xray/LICENSE xray/README.md


FROM alpine:3.24
COPY --from=builder /xray/* /
RUN set -ex \
	&& apk add --no-cache bash tzdata ca-certificates openssl \
	&& mkdir -p /var/log/xray /usr/share/xray \
  && mv /xray /usr/bin/ \
  && mv /geoip.dat /geosite.dat /usr/share/xray/

VOLUME /etc/xray
VOLUME /var/log/xray

ENV TZ=Asia/Tehran
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]