# Streaming Database Project

[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)

Read in: [Português](README.pt.md) | [English](README.md)

## Description

This is a MySQL project developed as the final project for the Introduction to Databases course. It models the data of a movie streaming service (similar to Netflix), covering customers, subscription plans, movies, regional availability, viewing history, favorites, and ratings. The project includes the database schema, a Python script to populate it with realistic fake data, and a set of analytical SQL queries.

## Features

- **Relational Schema**: Tables for regions, customers, plans, movies, subscriptions, regional availability, views, favorites, and ratings, connected through foreign keys.
- **Data Population**: A Python script using `Faker` generates realistic random data for all tables and inserts it into the database.
- **Analytical Queries**: A set of ready-to-use SQL queries covering common business questions (top movies, viewing time, favorites, ratings, plan popularity, playback quality, etc.).

## Project Structure

```
banco/       -> Database schema (table creation)
seed/        -> Script to populate the database with fake data
pesquisas/   -> Analytical SQL queries
```

### `banco/banco-streaming.sql`

Creates the `streaming` database and all its tables:

- `regiao` — geographic regions
- `cliente` — customers, linked to a region
- `plano` — subscription plans (price, device limit, playback quality)
- `filme` — movies (title, year, duration, genre, rating, studio, etc.)
- `assinatura` — customer subscriptions, linked to customer and plan
- `disponibilidade` — regional availability of each movie
- `visualizacao` — viewing history (customer, movie, date/time, duration, device)
- `favorito` — movies favorited by customers
- `avaliacao` — customer ratings for movies (1 to 5)

### `seed/popular_banco.py`

Connects to the MySQL database and populates all tables with fake but consistent data, using the `Faker` library and a fixed seed (`123`) for reproducibility.

### `pesquisas/`

Ten SQL queries (`pesquisa-01.sql` to `pesquisa-10.sql`) answering analytical questions such as:

- Movies available in each region
- Customers' favorite movies
- Average rating per movie
- Movies never viewed
- Total views and minutes watched per movie
- Hours watched per genre
- Active customers per plan
- Most-watched movies
- Playback quality distribution
- Subscription history per customer

## Getting Started

### Prerequisites

- MySQL Server
- Python 3 with the `mysql-connector-python` and `Faker` packages:

```bash
pip install mysql-connector-python Faker
```

### Setup

1. Create the schema:

```bash
mysql -u root -p < banco/banco-streaming.sql
```

2. Update the database connection credentials in `seed/popular_banco.py` (host, user, password), then populate the database:

```bash
python seed/popular_banco.py
```

3. Run the analytical queries in `pesquisas/` against the `streaming` database using your preferred MySQL client.

## Author

Lucas Nicolau — Software Engineering Student at @UFAM
