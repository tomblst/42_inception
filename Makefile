NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/tbellest/data

.PHONY: all build up down clean fclean re logs status

all: build up

build:
	@echo "Building containers..."
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@cd srcs && docker-compose -f docker-compose.yml build
	@echo "Build completed"

up:
	@echo "Starting services..."
	@cd srcs && docker-compose -f docker-compose.yml up -d
	@echo "Services started"
	@echo "Website available at: https://tbellest.42.fr"

down:
	@echo "Stopping services..."
	@cd srcs && docker-compose -f docker-compose.yml down
	@echo "Services stopped"

logs:
	@cd srcs && docker-compose -f docker-compose.yml logs -f

status:
	@docker ps -a --filter "name=nginx\|mariadb\|wordpress"
	@echo ""
	@docker network ls --filter "name=inception"
	@echo ""
	@docker volume ls --filter "name=srcs"

clean:
	@echo "Removing containers..."
	@docker rm -f nginx mariadb wordpress 2>/dev/null || true
	@echo "Containers removed"

fclean: clean
	@echo "Full cleanup..."
	@cd srcs && docker-compose -f docker-compose.yml down -v --rmi all 2>/dev/null || true
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)
	@echo "Full cleanup completed"

re: fclean all
