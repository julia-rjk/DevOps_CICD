FROM postgres:11.6-alpine
ENV POSTGRES_DB=cpe \
POSTGRES_USER=julia \
POSTGRES_PASSWORD=julia

COPY ./docker-entrypoint-initdb.d/01-CreateScheme.sql /docker-entrypoint-initdb.d/
COPY ./docker-entrypoint-initdb.d/02-InsertData.sql /docker-entrypoint-initdb.d/