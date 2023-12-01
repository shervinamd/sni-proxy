# SNI Proxy

## To Build Images
```bash
docker compose build
# OR
docker build -t sni-proxy:v1 ./sni.Dockerfile
docker build -t v2rayc:v1 ./v2ray.Dockerfile
```

## Changes before start

- **Update `config.json` with your own configuration**
- **Create a suitable docker network for services**
- **Update `IP` environment variable (in the `sni` service section) with your machine's IP address**

> **Note**: `SOCKS_IP` and `SOCKS_PORT` must match with the V2ray container address and service port

> **Note**: `dnsmasq.conf` file contains Restricted services
> You can add more if needed

## Start the service

change environment variables in `docker-compose.yml` to your desired values, then start the services
```bash
docker compose up -d
```


## License
This project Licensed under [MIT License](LICENSE)
