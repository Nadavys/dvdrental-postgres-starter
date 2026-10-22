FROM postgres:18.6

COPY datasources/dvdrental.sql /docker-entrypoint-initdb.d/01_dvdrental.sql
COPY datasources/02_extensions.sql /docker-entrypoint-initdb.d/02_extensions.sql

ENV POSTGRES_DB=dvdrental
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_INITDB_ARGS="--encoding=UTF8 --locale=en_US.utf8"
ENV LANG=en_US.utf8
