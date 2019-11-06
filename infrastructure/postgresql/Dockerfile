FROM postgres

ARG POSTGRES_PORT
EXPOSE $POSTGRES_PORT

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD secret
ENV POSTGRES_DB backend-test

COPY --chown=postgres:postgres *.conf *.key *.crt /var/lib/postgresql/initial_config/
COPY --chown=postgres:postgres *.sh *.sql /docker-entrypoint-initdb.d/
