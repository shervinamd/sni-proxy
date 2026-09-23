FROM ubuntu:22.04 AS extractor
ARG TUN2SOCKS_VERSION=$TUN2SOCKS_VERSION
ARG T2S=https://github.com/xjasonlyu/tun2socks/releases/download/${TUN2SOCKS_VERSION}/tun2socks-linux-amd64.zip
ADD ${T2S} .
RUN apt update && \
    apt install -y unzip && \
    unzip tun2socks-linux-amd64.zip

FROM ubuntu:22.04
COPY --from=extractor /tun2socks-linux-amd64 ./tun2socks
COPY sni-entrypoint.sh /entrypoint.sh
RUN apt update && \
    apt install -y sniproxy dnsmasq iptables iproute2 ca-certificates && \
    chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]