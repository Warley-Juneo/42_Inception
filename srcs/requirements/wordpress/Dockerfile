FROM debian:stable-slim

RUN apt update && apt install -y wget && apt install -y unzip
RUN mkdir -p /run/php
RUN wget https://wordpress.org/latest.zip
RUN mkdir -p /var/www/localhost
RUN unzip latest.zip
RUN chown -R www-data:www-data /var/www/localhost

RUN apt install -y php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip
RUN rm -r /etc/php/7.4/fpm/pool.d/www.conf

RUN echo "<h1>Hello World, You see my docker" > /var/www/localhost/index.html;
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
CMD ["php-fpm7.4", "-F"]

