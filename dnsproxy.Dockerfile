FROM ubuntu:22.04 AS extractor
RUN apt update && apt install -y unzip
ADD https://github.com/AdguardTeam/dnsproxy/releases/download/v0.77.0/dnsproxy-linux-amd64-v0.77.0.tar.gz .
ADD https://github.com/xjasonlyu/tun2socks/releases/download/v2.6.0/tun2socks-linux-amd64.zip .
RUN tar xvf dnsproxy-linux-amd64-v0.77.0.tar.gz && unzip tun2socks-linux-amd64.zip
FROM ubuntu:22.04
RUN apt update && apt install -y ca-certificates iptables iproute2 && apt autoclean && apt autoremove
WORKDIR /service
COPY --from=extractor /linux-amd64/dnsproxy .
COPY --from=extractor /tun2socks-linux-amd64 ./tun2socks
COPY dnsproxy-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]