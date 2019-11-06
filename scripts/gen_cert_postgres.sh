#!/bin/sh

NGINX_DIR="infrastructure/postgresql"
openssl req \
    -nodes \
    -newkey rsa:4096 \
    -sha512 -x509 \
    -days 365 \
    -out $NGINX_DIR/server.crt \
    -keyout $NGINX_DIR/server.key && \
chmod og-rwx server.key
