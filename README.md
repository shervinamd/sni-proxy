# SNI Proxy

## To Build Images
```bash
docker compose build
# OR
docker build -t sni-proxy:v1 ./sni.Dockerfile
docker build -t v2rayc:v1 ./v2ray.Dockerfile
```

## Start the service
change environment variables in `docker-compose.yml` to your desired values, then start the services
```bash
docker compose up -d
```
