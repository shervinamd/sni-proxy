FROM ubuntu:22.04 AS extractor
ARG TUN2SOCKS_VERSION=$TUN2SOCKS_VERSION
ARG DNSPROXY_VERSION=$DNSPROXY_VERSION
RUN apt update && apt install -y unzip
ADD https://github.com/AdguardTeam/dnsproxy/releases/download/${DNSPROXY_VERSION}/dnsproxy-linux-amd64-${DNSPROXY_VERSION}.tar.gz .
ADD https://github.com/xjasonlyu/tun2socks/releases/download/${TUN2SOCKS_VERSION}/tun2socks-linux-amd64.zip .
RUN tar xvf dnsproxy-linux-amd64-${DNSPROXY_VERSION}.tar.gz && unzip tun2socks-linux-amd64.zip
FROM ubuntu:22.04
RUN apt update && apt install -y ca-certificates iptables iproute2 && apt autoclean && apt autoremove
WORKDIR /service
COPY --from=extractor /linux-amd64/dnsproxy .
COPY --from=extractor /tun2socks-linux-amd64 ./tun2socks
COPY dnsproxy-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]