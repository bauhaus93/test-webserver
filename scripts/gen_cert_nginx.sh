#!/bin/sh

NGINX_DIR="infrastructure/nginx"
openssl req \
    -nodes \
    -newkey rsa:4096 \
    -sha512 -x509 \
    -days 365 \
    -out $NGINX_DIR/localhost.crt \
    -keyout $NGINX_DIR/localhost.key && \
chmod og-rwx $NGINX_DIR/localhost.key
