#!/bin/sh

gen_cert_if_not_existing() {
	[ ! -f $1/$2.crt ] && [ ! -f $1/$2.key ] && \
	openssl req \
		-nodes \
		-newkey rsa:4096 \
		-sha512 -x509 \
		-days 365 \
		-out $1/$2.crt \
		-keyout $1/$2.key && \
	chmod og-rwx $1/$2.key
}

gen_cert_if_not_existing "infrastructure/nginx" "nginx"
gen_cert_if_not_existing "infrastructure/postgresql" "postgres"
