#!/bin/sh

ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/server.conf
rm -rf /etc/nginx/sites-enabled/default


mkdir	/etc/nginx/ssl && \
openssl	req -newkey rsa:2048 \
	    -x509 \
	    -sha256 \
	    -days 365 \
	    -nodes \
	    -out /etc/nginx/ssl/nginx-ssl.crt \
	    -keyout /etc/nginx/ssl/nginx-ssl.key \
	    -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

service mysql start
mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER IF NOT EXISTS 'wpuser'@'localhost' IDENTIFIED BY 'dbpassword';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

wget --no-check-certificate https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz 
rm -rf latest.tar.gz
mv wordpress /var/www/html/wordpress
mv wp-config.php /var/www/html/wordpress

wget -O phpmyadmin.tar.gz --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpmyadmin.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
rm -rf  phpmyadmin.tar.gz

chown -R www-data /var/www/html/
chmod 440 /var/www/html/wordpress/wp-config.php

service nginx start
service php7.3-fpm start

tail -f	/var/log/nginx/access.log
