FROM debian:buster

RUN apt update && apt install -y wget && apt install -y unzip && apt install -y curl && apt install -y nano

RUN mkdir -p /run/php
# RUN touch /run/php/php7.3-fpm.sock
RUN chown -R www-data:www-data /run/php

RUN apt install -y php7.3-fpm

RUN sed -i 's/;listen\.owner/listen.owner/g' /etc/php/7.3/fpm/pool.d/www.conf \
    && sed -i 's/;listen\.group/listen.group/g' /etc/php/7.3/fpm/pool.d/www.conf \
    && sed -i 's/;listen\.mode/listen.mode/g' /etc/php/7.3/fpm/pool.d/www.conf \
    && sed -i 's/listen = \/run\/php\/php7.3-fpm\.sock/listen = 0\.0\.0\.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf && service php7.3-fpm restart

RUN mkdir -p /var/www/wordpress && \
    wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    chown -R www-data:www-data /var/www/wordpress && \
    find /var/www/wordpress/ -type d -exec chmod 750 {} \; && \
    find /var/www/wordpress/ -type f -exec chmod 640 {} \;


RUN echo "<h1>Hello World, You see my docker with wordpress" > /var/www/wordpress/index.php;

CMD ["php-fpm7.3", "-F"]

# php7.3-mysql php7.3-curl php7.3-gd php7.3-intl php7.3-mbstring php7.3-soap php7.3-xml php7.3-xmlrpc php7.3-zip
