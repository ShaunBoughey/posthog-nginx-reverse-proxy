FROM ubuntu:latest

ADD nginx.conf.template nginx.conf.template

RUN apt-get update

RUN apt-get install -y gettext-base

ARG SERVER_NAME

ARG PORT

ARG POSTHOG_HOST=app.posthog.com

RUN envsubst '$SERVER_NAME,$PORT,$POSTHOG_HOST' < nginx.conf.template > nginx.conf

FROM nginx:latest

COPY --from=0 nginx.conf /etc/nginx/nginx.conf

RUN cat /etc/nginx/nginx.conf