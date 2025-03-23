#!/bin/sh

sed -i "s/socks4/socks5/g; s/127\.0\.0\.1/${SOCKS_IP}/g; s/9050/${SOCKS_PORT}/g" /etc/proxychains4.conf
/usr/bin/proxychains /service/dnsproxy --config-path=/service/config.yaml