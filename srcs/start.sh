#!/bin/bash

#autoindex setting
sed -i s/%AUTOINDEX%/$AUTOINDEX/g /etc/nginx/sites-available/server.conf

#make symbolic link of server.conf in sites-eneable
ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/server.conf
rm -rf /etc/nginx/sites-enabled/default

#setting of ssl
mkdir	/etc/nginx/ssl && \
openssl	req -newkey rsa:2048 \
	    -x509 \
	    -sha256 \
	    -days 365 \
	    -nodes \
	    -out /etc/nginx/ssl/nginx-ssl.crt \
	    -keyout /etc/nginx/ssl/nginx-ssl.key \
	    -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

#setting of mysql
service mysql start
mysql -e "CREATE DATABASE ft_server;"
mysql -e "CREATE USER IF NOT EXISTS 'user42'@'localhost' IDENTIFIED BY 'user42';"
mysql -e "GRANT ALL PRIVILEGES ON ft_server.* TO 'user42'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

#get wordpress
wget --no-check-certificate https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz 
rm -rf latest.tar.gz
mv wordpress /var/www/html/wordpress
mv wp-config.php /var/www/html/wordpress
#get phpmyadmin
wget -O phpmyadmin.tar.gz --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpmyadmin.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
rm -rf  phpmyadmin.tar.gz

#need conf for phpmyadmin for erasing the warning
mv  config.inc.php /var/www/html/phpmyadmin/config.inc.php

#change the ownership and authority
chown -R www-data /var/www/html/
chmod 440 /var/www/html/wordpress/wp-config.php

service nginx start
service php7.3-fpm start

#keep moving the container
tail -f	/var/log/nginx/access.log
