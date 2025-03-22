FROM ubuntu:22.04 AS extractor
ADD https://github.com/AdguardTeam/dnsproxy/releases/download/v0.71.1/dnsproxy-linux-amd64-v0.71.1.tar.gz .
RUN tar xvf dnsproxy-linux-amd64-v0.71.1.tar.gz
FROM ubuntu:22.04
RUN apt update && apt install -y proxychains4 ca-certificates && apt autoclean && apt autoremove
WORKDIR /service
COPY --from=extractor /linux-amd64/dnsproxy .
CMD ["/usr/bin/proxychains","-f","/service/proxychains.conf","/service/dnsproxy","--config-path=/service/config.yaml"]
