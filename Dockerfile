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
	php-mbstring \
	php-zip \
	php-net-socket \
	php-gd \
	php-gettext \
	php-mysql \
	php-bcmath \
	wget 
 
	

COPY	./srcs/start.sh ./
COPY	./srcs/server.conf ./etc/nginx/sites-available/server.conf
COPY	./srcs/wp-config.php ./wp-conf.php

CMD	bash ./start.sh
