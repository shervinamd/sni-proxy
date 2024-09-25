FROM ubuntu:22.04 AS extractor
ARG V2RAY=https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-64.zip
ADD ${V2RAY} .
RUN apt update && \
    apt install -y unzip && \
    mkdir /v2ray && \
    unzip v2ray-linux-64.zip -d /v2ray

FROM ubuntu:22.04
RUN apt update && apt install -y ca-certificates && apt autoclean && apt autoremove
WORKDIR /v2ray
COPY --from=extractor /v2ray/. .
CMD ["/v2ray/v2ray","run","/v2ray/config.json"]
