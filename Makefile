DB_NAME = mariadb
NGX_NAME = nginx
WP_NAME = wordpress
NTW_NAME = my-network

all: init_service

init_service:
	cd srcs && docker-compose up -d
	cd ..

restart:
	cd srcs && docker-compose restart
	cd ..

clean_ps:
	# docker rm -f $$(docker ps -a | grep $(DB_NAME) | awk '{print $$1}')
	docker rm -f $$(docker ps -a | grep $(NGX_NAME) | awk '{print $$1}')
	docker rm -f $$(docker ps -a | grep $(WP_NAME) | awk '{print $$1}')

clean_network:
	@docker network rm $$(docker network ls | grep $(NTW_NAME) | awk '{print $$1}')

clean_imgs:
	# docker rmi -f $$(docker images | grep $(DB_NAME) | awk '{print $$3}')
	docker rmi -f $$(docker images | grep $(NGX_NAME) | awk '{print $$3}')
	docker rmi -f $$(docker images | grep $(WP_NAME) | awk '{print $$3}')

 clean_volumes:
# 	docker volume rm srcs_wordpress-db
# 	docker volume rm srcs_wordpress-files

checks:
	@echo "\t\tContainers:"
	@docker ps -all
	@echo "\n\t\tImages:"
	@docker images
	@echo "\n\t\tNetworks:"
	@docker network ls
	@echo "\n\t\tVolumes:"
	@docker volume ls

cleanup: clean_ps clean_network clean_imgs clean_volumes checks

re: cleanup all

.phony: all init_service restart clean_ps clean_network clean_imgs clean_volumes checks cleanup re
