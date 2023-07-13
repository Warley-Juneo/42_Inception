#Iniciando o servido mysql
service mysql start

# Criando uma nova base de dados
mysql -e "CREATE DATABASE $MYSQL_DATABASE"

# Criando um user que nao vai ser local '%' e um password
mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"

# Dando todos os privilegios para o usuario e para data de base
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'"

# Alterando a senha root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';FLUSH PRIVILEGES"

# Alterando a senha no arquivo de configuração do mysql debian
sed -i "s/password =/password = $MYSQL_ROOT_PASSWORD/g" /etc/mysql/debian.cnf

service mysql stop && mysqld_safe