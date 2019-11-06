#/bin/sh

BUILD_DIR="$PWD/build"
INFRA_DIR="$PWD/infrastructure"

ELM_DIR="$PWD/frontend-elm"
SERVER_DIR="$PWD/backend-server"
NGINX_DIR="$INFRA_DIR/nginx"
POSTGRES_DIR="$INFRA_DIR/postgresql"

ELM_BUILD_DIR="$ELM_DIR/build"
SERVER_CONTEXT_DIR="$BUILD_DIR/server"
NGINX_CONTEXT_DIR="$BUILD_DIR/nginx"
POSTGRES_CONTEXT_DIR="$BUILD_DIR/postgresql"

BACKEND_SUBNET="172.16.10.0/24"
BACKEND_SERVER_IP="172.16.10.10"
BACKEND_POSTGRES_IP="172.16.10.11"

FRONTEND_SUBNET="172.16.11.0/24"
FRONTEND_SERVER_IP="172.16.11.10"
FRONTEND_NGINX_IP="172.16.11.11"

POSTGRES_PORT="5432"
NGINX_PORT="80"
SERVER_PORT="10001"

export NGINX_CONTEXT_DIR POSTGRES_CONTEXT_DIR SERVER_CONTEXT_DIR
export BACKEND_SUBNET BACKEND_SERVER_IP BACKEND_POSTGRES_IP
export FRONTEND_SUBNET FRONTEND_SERVER_IP FRONTEND_NGINX_IP
export POSTGRES_PORT NGINX_PORT SERVER_PORT

rm -rf $BUILD_DIR && \
mkdir -p $BUILD_DIR $NGINX_CONTEXT_DIR $POSTGRES_CONTEXT_DIR $SERVER_CONTEXT_DIR && \
pushd $ELM_DIR && \
scripts/build.sh && \
popd && \
rsync -a $NGINX_DIR/* $NGINX_CONTEXT_DIR/ && \
rsync -a $POSTGRES_DIR/* $POSTGRES_CONTEXT_DIR/ && \
rsync -a $SERVER_DIR/* $SERVER_CONTEXT_DIR/ --exclude target && \
cp -r $ELM_BUILD_DIR/* $NGINX_CONTEXT_DIR/www && \
envsubst < $NGINX_DIR/nginx.conf.in > $NGINX_CONTEXT_DIR/nginx.conf && \
envsubst < $POSTGRES_DIR/postgresql.conf.in > $POSTGRES_CONTEXT_DIR/postgresql.conf && \
envsubst < $POSTGRES_DIR/pg_hba.conf.in > $POSTGRES_CONTEXT_DIR/pg_hba.conf && \
envsubst < $SERVER_DIR/settings.toml.in > $SERVER_CONTEXT_DIR/settings.toml && \
docker-compose down -v  && \
docker-compose up --build --remove --abort-on-container-exit
