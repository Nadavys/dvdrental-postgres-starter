# Project: DVD Rental Postgres Starter

A ready-to-run PostgreSQL loaded with the `dvdrental` sample database.

## Purpose

Drop-in Postgres with realistic sample data, for use by any project, tool, or tutorial.

## Stack

- **PostgreSQL 18** — dvdrental DB in Docker (`dvdrental_db/`)
  - Plain SQL dump `dvdrental_db/datasources/dvdrental.sql`, loaded via `docker-entrypoint-initdb.d` on first init
  - `pg_stat_statements` enabled (`02_extensions.sql`)
- **Docker Compose** — single `docker-compose.yml` spins everything up
- **Adminer** — DB UI at http://localhost:8080
- **PgHero** — performance dashboard at http://localhost:8081
- **pgAdmin** — full-featured DB UI at http://localhost:8082 (desktop mode, no login)

Connection: `postgresql://postgres:postgres@localhost:5432/dvdrental`

Ports are configurable via `.env` (see `.env.example`): `POSTGRES_PORT`, `ADMINER_PORT`, `PGHERO_PORT`, `PGADMIN_PORT`.

## Make Commands

- `make up` — start all services
- `make down` — stop all services
- `make reset` — wipe volumes, rebuild and restart fresh
- `make logs` — tail logs
- `make psql` — psql shell in `dvdrental`

## Key Directories

- `dvdrental_db/` — Postgres Docker build with the dvdrental dump and init scripts
- `pgadmin/servers.json` — pre-configured pgAdmin server connection
