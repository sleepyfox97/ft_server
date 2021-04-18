# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: khiroshi <khiroshi@student.42tokyo.>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/03 02:04:29 by khiroshi          #+#    #+#              #
#    Updated: 2021/04/03 02:04:30 by khiroshi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	debian:buster

LABEL	com.42tokyo.vendor="sleepyfox"

ENV	AUTOINDEX=on

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
	php-common \
	php-fpm \
	php-pear \
	php-mbstring \
	php-zip \
	php-net-socket \
	php-gd \
	php-mysql \
	php-xml-util \
	php-gettext \
	php-bcmath \
	wget

COPY	./srcs/start.sh ./
COPY	./srcs/server.conf ./etc/nginx/sites-available/server.conf
COPY	./srcs/wp-config.php ./wp-config.php
COPY	./srcs/config.inc.php ./config.inc.php

CMD	bash ./start.sh
