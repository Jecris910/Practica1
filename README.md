# Practica 1 - Multi-environment deployment

Docker-based multi-environment application developed for the Advanced Networks course.

The project deploys a Flask web application connected to a MySQL database. In the production environment, Redis is also used as a cache.

## Architecture

### Development

    Browser
       |
       v
    Flask Web
       |
       v
     MySQL

Development uses two services:

- `web`: Flask application.
- `db`: MySQL database.

Redis is not used in development.

### Production

              +----------+
              | Browser  |
              +----+-----+
                   |
                   v
              +----+-----+
              |Flask Web |
              +--+----+--+
                 |    |
                 v    v
              MySQL  Redis
               DB    Cache

Production uses three services:

- `web`: Flask application.
- `db`: MySQL database.
- `cache`: Redis cache.

Only the web application exposes a port to the host. MySQL and Redis communicate through the internal Docker network.

## Project structure

    .
    ├── app/
    │   ├── app.py
    │   ├── Dockerfile
    │   └── requirements.txt
    ├── cache/
    │   └── Dockerfile
    ├── config/
    │   ├── .env.dev
    │   └── .env.prod
    ├── db/
    │   ├── Dockerfile
    │   └── init.sql
    ├── docker-compose.dev.yml
    ├── docker-compose.prod.yml
    ├── Makefile
    └── README.md

The real environment files are ignored by Git because they contain credentials.

## Requirements

The following software is required:

- Docker
- Docker Compose
- GNU Make
- Git

## Environment configuration

Two environment files are used:

    config/.env.dev
    config/.env.prod

Example development configuration:

    WEB_PORT=5000
    MYSQL_HOST=db
    MYSQL_PORT=3306
    MYSQL_DATABASE=practica1
    MYSQL_USER=practica1_user
    MYSQL_PASSWORD=devpassword
    MYSQL_ROOT_PASSWORD=rootpassword

Example production configuration:

    WEB_PORT=5000
    MYSQL_HOST=db
    MYSQL_PORT=3306
    MYSQL_DATABASE=practica1
    MYSQL_USER=practica1_user
    MYSQL_PASSWORD=prodpassword
    MYSQL_ROOT_PASSWORD=prodrootpassword
    REDIS_HOST=cache
    REDIS_PORT=6379

## Running the application

### Development environment

Start development:

    make up-dev

Check development containers:

    make status-dev

Stop development:

    make down-dev

### Production environment

Start production:

    make up-prod

Check production containers:

    make status-prod

Stop production:

    make down-prod

### Stop all environments

    make down

### Build both environments

    make build

## Application endpoints

### /

Basic application endpoint.

    http://localhost:5000/

### /status

Shows the connection status of the application services.

Development example:

    {
      "cache": "not configured",
      "database": "connected",
      "web": "connected"
    }

Production example:

    {
      "cache": "connected",
      "database": "connected",
      "web": "connected"
    }

### /teams

Returns the teams stored in MySQL.

In production, Redis caches the result for 60 seconds.

The first request obtains the information from MySQL:

    {
      "source": "database",
      "teams": [...]
    }

Following requests while the cached value is valid use Redis:

    {
      "source": "cache",
      "teams": [...]
    }

This demonstrates that Redis is being used as an application cache rather than only running as an additional container.

## Database

MySQL stores Inazuma Eleven themed information.

The database currently contains:

- 5 teams from Original Season 1.
- 5 teams from Original Season 2.
- 5 teams from Original Season 3.
- 5 teams from Inazuma Eleven GO.
- An Inazuma Japan starting eleven.
- Player positions.
- Player elements.
- Two special moves for each stored player.
- Relationships between players and teams.

The schema and initial data are defined in:

    db/init.sql

The initialization script is mounted in:

    /docker-entrypoint-initdb.d/init.sql

This allows MySQL to create the schema and initial data automatically when a new database volume is initialized.

## Data persistence

MySQL uses Docker named volumes so database information is not stored only inside the container.

Development and production use separate volumes.

Persistence was tested with the following procedure:

1. Verify that 11 players existed in the database.
2. Stop the MySQL container.
3. Remove the MySQL container without deleting its volume.
4. Recreate the MySQL container.
5. Query the database again.
6. Verify that all 11 players were still available.

The test confirmed that the data survives container recreation.

## Healthchecks

The application services include Docker healthchecks.

### Web

The Flask image checks the `/status` endpoint:

    http://localhost:5000/status

### Database

The MySQL image uses:

    mysqladmin ping

### Cache

The Redis image uses:

    redis-cli ping

A healthy production deployment can be verified with:

    docker ps

The three production services should appear as healthy:

    practica1prod_web_1
    practica1prod_db_1
    practica1prod_cache_1

## Redis cache test

The Redis cache can be demonstrated using the `/teams` endpoint.

First request:

    wget -qO- http://localhost:5000/teams

The response should contain:

    "source":"database"

Run the same command again before the 60 second cache expires:

    wget -qO- http://localhost:5000/teams

The response should now contain:

    "source":"cache"

This demonstrates that the first query is obtained from MySQL and subsequent requests can be served from Redis.

## Networking and security

The project uses an internal Docker network for communication between containers.

Only the Flask web application publishes a port to the host.

MySQL and Redis do not publish their service ports to the host.

Credentials and environment-specific values are stored in `.env` files instead of being hardcoded in the application source code.

The `.env` files are ignored by Git.

Development and production also use different Docker Compose project names and independent database volumes.

## Development and production differences

| Feature | Development | Production |
| --- | --- | --- |
| Flask web service | Yes | Yes |
| MySQL database | Yes | Yes |
| Redis cache | No | Yes |
| Internal Docker network | Yes | Yes |
| Persistent MySQL volume | Yes | Yes |
| Web healthcheck | Yes | Yes |
| Database healthcheck | Yes | Yes |
| Redis healthcheck | No Redis service | Yes |
| Cache status | Not configured | Connected |
| Redis caching | No | Yes |

## Useful tests

Check application status:

    wget -qO- http://localhost:5000/status

Check teams and cache operation:

    wget -qO- http://localhost:5000/teams

Check Docker container health:

    docker ps

Check development environment:

    make status-dev

Check production environment:

    make status-prod

## Technologies

- Docker
- Docker Compose
- Python 3.11
- Flask 2.3.3
- MySQL 5.7
- Redis
- PyMySQL
- redis-py
- Git
- GNU Make

MySQL 5.7 is used instead of MySQL 8.0 because MySQL 8.0 presented thread compatibility problems in the Ubuntu 16.04 virtual machine used during development.

Flask runs with threading disabled because of thread limitations in the development virtual machine.

## Automation

A `Makefile` is provided to simplify the main Docker operations.

Available commands:

    make build
    make up-dev
    make up-prod
    make down-dev
    make down-prod
    make down
    make status-dev
    make status-prod

Development and production use different Docker Compose project names to prevent container, network and volume conflicts.

## Artificial Intelligence disclosure

Artificial intelligence was used during the development of this project.

- Tool: OpenAI ChatGPT
- Model: GPT-5.6 Sol
- Purpose: assistance with Docker configuration, Flask development, database design, Redis integration, debugging, testing and documentation.
- Usage: AI assistance was used to propose commands, code changes and explanations. The resulting configuration and application were executed, tested and reviewed by the student.

## Repository

The project is maintained using Git and published in a public GitHub repository.

Development was performed incrementally with small commits for individual features, fixes and configuration changes.
