.PHONY: up down reset logs psql

up:
	docker compose up -d

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up -d --build

logs:
	docker compose logs -f

psql:
	docker compose exec db psql -U postgres -d dvdrental
