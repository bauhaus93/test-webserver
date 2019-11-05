#!/bin/sh

BASE=$PWD

cd test-elm && \
	scripts/build.sh

cd $BASE && \
	docker-compose up --build --remove -d postgres nginx

cd test-backend/server && \
	scripts/run_release.sh
