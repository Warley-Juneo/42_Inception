#!/bin/bash
sleep 5
wp core config --dbhost=$WORDPRESS_DB_HOST --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --allow-root --path=/var/www/html/wordpress
wp core install --url=$URL --title=42SP --admin_name=$ADM_NAME --admin_password=$ADM_PASSWORD --admin_email=$ADM_EMAIL --allow-root --path=/var/www/html/wordpress
wp user create wjuneo-f $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --allow-root --path=/var/www/html/wordpress
php-fpm7.3 -F