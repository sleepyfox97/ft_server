FROM debian:buster

MAINTAINER sleepyfox

RUN set -ex; \
	apt-get update; \
	apt-get install -y nginx \
	curl \
	wget \
	vim \
	openssl\
	mariadb-server \
	mariadb-client \
	php-fpm \
