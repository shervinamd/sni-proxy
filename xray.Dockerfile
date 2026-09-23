FROM alpine:latest AS builder
ARG XRAY_VERSION=$XRAY_VERSION
RUN wget -c https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip \
  && unzip -d xray Xray-linux-64.zip


FROM alpine:3.24
COPY --from=builder /xray/xray /usr/bin/xray
RUN set -ex \
	&& apk add --no-cache bash tzdata ca-certificates openssl \
	&& mkdir -p /var/log/xray /usr/share/xray

ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat /usr/share/xray/geosite.dat
ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat /usr/share/xray/geoip.dat

VOLUME /etc/xray
VOLUME /var/log/xray

ENV TZ=Asia/Tehran
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]