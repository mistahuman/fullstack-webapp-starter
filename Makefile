.PHONY: init up down build logs ps

init:
	@bash setup.sh

up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build

logs:
	docker compose logs -f

ps:
	docker compose ps
