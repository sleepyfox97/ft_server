FROM		debian:buster

MAINTAINER	sleepyfox

RUN	apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get --no-install-recommends -y install\
	nginx \
	vim \
	openssl \
	php  \
	php-fpm \
	mariadb-server \
	mariadb-client \
	php-cgi \
	php-fpm \
	php-pear \
	php-zip \
	php-net-socket \
	php-gd \
	php-mysql \
	wget  

COPY	./srcs/start.sh ./
COPY	./srcs/server.conf ./etc/nginx/sites-available/server.conf
COPY	./srcs/wp-config.php ./wp-config.php

CMD	bash ./start.sh
