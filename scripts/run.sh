#!/bin/sh

BASE=$PWD

cd test-elm && \
	scripts/build.sh

cd $BASE && \
	docker-compose down -v  && \
	docker-compose up --build --remove --abort-on-container-exit
