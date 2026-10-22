# DVD Rental Postgres Starter

A ready-to-run PostgreSQL loaded with the classic **dvdrental** sample database (Sakila port for Postgres): a DVD rental store with films, actors, categories, customers, stores, staff, inventory, rentals and payments.

Spin it up and point any project, tool, or tutorial at it.

## Stack

- **PostgreSQL 18** — `dvdrental` database restored automatically on first startup
- **Adminer** — lightweight DB UI at http://localhost:8080
- **PgHero** — performance dashboard at http://localhost:8081 (uses `pg_stat_statements`)
- **pgAdmin** — full-featured Postgres UI at http://localhost:8082 (desktop mode, no login; the DB password is `postgres`)

## Quick Start

```bash
make up
```

The first startup loads `dvdrental.sql`, which takes a few seconds. The `db` service reports healthy once it's done.

## Changing Ports

Defaults are `5432` (Postgres), `8080` (Adminer), `8081` (PgHero) and `8082` (pgAdmin). If one clashes with something already running, copy `.env.example` to `.env` and change it:

```bash
cp .env.example .env
# e.g. ADMINER_PORT=8083
make up
```

## Make Commands

| Command      | Action                                   |
|--------------|------------------------------------------|
| `make up`    | Start all services                       |
| `make down`  | Stop all services                        |
| `make reset` | Wipe volumes, rebuild, and restart fresh |
| `make logs`  | Tail logs from all services              |
| `make psql`  | Open a psql shell in `dvdrental`         |

## Connection Details

| Parameter | Value       |
|-----------|-------------|
| Host      | `localhost` |
| Port      | `5432`      |
| Database  | `dvdrental` |
| User      | `postgres`  |
| Password  | `postgres`  |

```
postgresql://postgres:postgres@localhost:5432/dvdrental
```

```bash
psql -h localhost -U postgres -d dvdrental
```

## Schema Overview

15 tables, plus views (`actor_info`, `customer_list`, `film_list`, `sales_by_store`, …) and functions (`film_in_stock`, `get_customer_balance`, `rewards_report`, …).

| Area      | Tables                                                    |
|-----------|-----------------------------------------------------------|
| Films     | `film`, `actor`, `film_actor`, `category`, `film_category`, `language` |
| Inventory | `inventory`, `store`                                      |
| Business  | `rental`, `payment`, `customer`, `staff`                  |
| Location  | `address`, `city`, `country`                              |

Example query:

```sql
SELECT c.name AS category, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r         USING (rental_id)
JOIN inventory i      USING (inventory_id)
JOIN film_category fc USING (film_id)
JOIN category c       USING (category_id)
GROUP BY c.name
ORDER BY revenue DESC;
```

## Project Layout

```
dvdrental_db/
  Dockerfile                          # postgres:18 image with the dump baked in
  datasources/
    dvdrental.sql                     # plain SQL dump (schema + data)
    02_extensions.sql                 # enables pg_stat_statements
pgadmin/servers.json                  # pre-configured pgAdmin connection
docker-compose.yml
Makefile
.env.example                          # optional port overrides (copy to .env)
```

All ports are bound to `127.0.0.1`, so the database and UIs are only reachable from your machine.

## Using the Dump Elsewhere

`dvdrental_db/datasources/dvdrental.sql` is a plain SQL file, so you can load it into any Postgres:

```bash
createdb dvdrental
psql -d dvdrental -f dvdrental_db/datasources/dvdrental.sql
```

## Re-initializing the Database

Init scripts only run when the data volume is empty. To start from a clean copy:

```bash
make reset
```

## Data Source and License

The `dvdrental` database is the sample from [postgresqltutorial.com](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/), a PostgreSQL port of MySQL's [Sakila](https://dev.mysql.com/doc/sakila/en/) sample database, which is distributed under the New BSD License.

The project's own files (Docker, compose and docs) are MIT licensed. See [LICENSE](LICENSE). The Sakila copyright and license notice for the bundled data is in [NOTICE](NOTICE).
