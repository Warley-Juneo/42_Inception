FROM debian:buster

RUN apt update && apt install -y \
	php7.3-fpm\
	php7.3-mysqli \
	mariadb-client \
	wget \
	curl \
	unzip

# Dowload wp cli para realizar comandos wordpress via linha de comando
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp && wp cli update

# Criando a pasta do wordpress
RUN mkdir -p var/www/html/wordpress

# Dowload do wordpress pelo wp cli.
RUN wp core download --allow-root --path=/var/www/html/wordpress

# Mudando as permissoes, users e grupos
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 777 /var/www/html/

# Colocando o PHP-FPM pra rodar na porta 9000
RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.3/fpm/pool.d/www.conf

# Criando o diretorio aonde vai rodar o PHP-FPM
RUN mkdir -p /run/php && chmod 777 /var/run/php

#copiando o script que vai criar a base de dados e users.
COPY tools/wpconfig.sh ./script.sh

# Alterando as permissoes pata o docker conseguir executar
RUN chmod 777 script.sh

# expondo a porta e chamando o script
EXPOSE 9000
CMD ["bash", "./script.sh"]