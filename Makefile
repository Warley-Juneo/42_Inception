PASSWORD_SU = 4242

MD_NAME = mariadb
NG_NAME = nginx
WP_NAME = wordpress
MY_NETWORK = wordpress_network

PATH_COMPOSE = cd ./srcs
CUR_PATH = cd ..

all: init_service

init_service:
	@echo "Iniciando pré configuração e iniciando projeto"
	sudo chmod 777 /etc/hosts
	sudo cat /etc/hosts | sudo grep "wjuneo-f.42.fr" || sudo  echo  "127.0.0.1       wjuneo-f.42.fr" >> /etc/hosts
	sudo mkdir -p /home/wjuneo-f/wordpress && sudo chmod 777 /home/wjuneo-f/wordpress
	sudo mkdir -p /home/wjuneo-f/mariadb && sudo chmod 777 /home/wjuneo-f/mariadb
	$(PATH_COMPOSE) && docker-compose up -d
	$(CUR_PATH)

rebuild:
	$(PATH_COMPOSE) && sudo docker-compose build --no-cache
	$(CUR_PATH)

restart:
	$(PATH_COMPOSE) && docker-compose restart
	$(CUR_PATH)

clean_ps:
	docker rm -f $$(docker ps -a | grep $(MD_NAME) | awk '{print $$1}')
	docker rm -f $$(docker ps -a | grep $(NG_NAME) | awk '{print $$1}')
	docker rm -f $$(docker ps -a | grep $(WP_NAME) | awk '{print $$1}')

clean_network:
	@docker network rm $$(docker network ls | grep $(MY_NETWORK) | awk '{print $$1}')

clean_imgs:
	docker rmi -f $$(docker images | grep $(MD_NAME) | awk '{print $$3}')
	docker rmi -f $$(docker images | grep $(NG_NAME) | awk '{print $$3}')
	docker rmi -f $$(docker images | grep $(WP_NAME) | awk '{print $$3}')

clean_volumes:
	docker volume rm srcs_wordpress_data
	docker volume rm srcs_mariadb_data

checks:
	@echo "Containers:"
	@docker ps -all
	@echo "\nImages:"
	@docker images
	@echo "\nNetworks:"
	@docker network ls
	@echo "\nVolumes:"
	@docker volume ls

cleanup: clean_ps clean_network clean_imgs clean_volumes checks
	sudo rm -rf /home/wjuneo-f

re: cleanup all checks