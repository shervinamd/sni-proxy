# SNI Proxy

## To Build Images
```bash
docker compose build
```

## Changes before start

- **Update `config.json` with your own configuration**

- **Create a suitable docker network for services**

  ```shell
  docker network create \
    --driver=bridge \
    --subnet=192.168.25.0/24 \
    --ip-range=192.168.25.0/24 \
    --gateway=192.168.25.254 \
    containers
  ```

  

- **Replace `${SNI_HOST_IP}` variable (in the `sni` service section) with your host machine's IP address or define it in `.env` file**

> **Note**: `SOCKS_IP` and `SOCKS_PORT` must match with the V2ray container address and service port

> **Note**: `dnsmasq.conf` file contains Restricted services need to access
> You can add more if needed

## Start the service

change environment variables in `docker-compose.yml` to your desired values, then start the services
```bash
docker compose up -d
```


## License
This project Licensed under [MIT License](LICENSE)
