# Practica 1 - Multi-environment Deployment

Docker-based multi-environment application developed for the Advanced Networks course.

The project deploys a Flask web application connected to a MySQL database. In production, Redis is also used as a cache service.

The application uses Inazuma Eleven themed data to demonstrate database access, persistence, internal Docker networking, healthchecks, cache usage and differences between development and production environments.

---

## 1. Architecture

The project contains two independent environments:

- Development (`dev`)
- Production (`prod`)

### Development architecture

```text
          +----------+
          | Browser  |
          +----+-----+
               |
               | HTTP :5000
               v
          +----+-----+
          | Flask Web|
          +----+-----+
               |
               | Internal Docker Network
               v
          +----+-----+
          |  MySQL   |
          +----------+
```

Development contains two services:

- `web`
- `db`

Redis is not used in development.

### Production architecture

```text
                 +----------+
                 | Browser  |
                 +----+-----+
                      |
                      | HTTP :5000
                      v
                 +----+-----+
                 | Flask Web|
                 +--+----+--+
                    |    |
        Internal    |    | Internal
        Network     |    | Network
                    |    |
                    v    v
               +----+    +------+
               |                |
          +----+-----+      +---+---+
          |  MySQL   |      | Redis |
          +----------+      +-------+
```

Production contains three services:

- `web`
- `db`
- `cache`

Only the web application publishes a port to the host.

MySQL and Redis are accessible only through the internal Docker network.

---

## 2. Project structure

```text
.
├── app/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── templates/
│   │   └── index.html
│   └── static/
│       └── images/
│           ├── teams/
│           └── player images
│
├── cache/
│   └── Dockerfile
│
├── config/
│   ├── .env.dev.example
│   ├── .env.prod.example
│   ├── .env.dev
│   └── .env.prod
│
├── db/
│   ├── Dockerfile
│   └── init.sql
│
├── scripts/
│   ├── test-demo.sh
│   └── stop-demo.sh
│
├── docker-compose.dev.yml
├── docker-compose.prod.yml
├── Makefile
├── .gitignore
└── README.md
```

The real `.env` files are ignored by Git because they contain credentials.

Only the `.env.example` files are stored in the repository.

---

## 3. Technologies

The project uses:

- Docker
- Docker Compose
- Python 3.11
- Flask 2.3.3
- MySQL 5.7
- Redis
- PyMySQL
- redis-py
- HTML
- CSS
- JavaScript
- GNU Make
- Bash
- Git
- GitHub

MySQL 5.7 is used because MySQL 8.0 presented thread compatibility problems in the Ubuntu 16.04 virtual machine used during development.

Flask also runs with threading disabled because of thread limitations in the development virtual machine.

---

## 4. Requirements

The following software is required:

- Docker
- Docker Compose
- GNU Make
- Git
- Python 3

The project was developed and tested using Ubuntu 16.04 inside a VirtualBox virtual machine.

---

## 5. Environment configuration

The project uses a different environment file for development and production.

### Development

```text
config/.env.dev
```

Example:

```text
WEB_PORT=5000
MYSQL_HOST=db
MYSQL_PORT=3306
MYSQL_DATABASE=practica1
MYSQL_USER=practica1_user
MYSQL_PASSWORD=change_me
MYSQL_ROOT_PASSWORD=change_me
```

### Production

```text
config/.env.prod
```

Example:

```text
WEB_PORT=5000
MYSQL_HOST=db
MYSQL_PORT=3306
MYSQL_DATABASE=practica1
MYSQL_USER=practica1_user
MYSQL_PASSWORD=change_me
MYSQL_ROOT_PASSWORD=change_me
REDIS_HOST=cache
REDIS_PORT=6379
```

To create the real configuration files:

```bash
cp config/.env.dev.example config/.env.dev
cp config/.env.prod.example config/.env.prod
```

Then edit the real files and configure the desired passwords.

The real credentials are not included in Git.

---

## 6. Development environment

The development environment contains:

- Flask web application
- MySQL database
- Internal Docker network
- Persistent MySQL volume
- No Redis service

To start development:

```bash
make up-dev
```

To check the development containers:

```bash
make status-dev
```

To stop development:

```bash
make down-dev
```

The application can then be opened at:

```text
http://localhost:5000
```

Expected `/status` response in development:

```json
{
  "cache": "not configured",
  "database": "connected",
  "web": "connected"
}
```

This demonstrates that Redis is not configured in development.

---

## 7. Production environment

The production environment contains:

- Flask web application
- MySQL database
- Redis cache
- Internal Docker network
- Persistent MySQL volume

To start production:

```bash
make up-prod
```

To check production:

```bash
make status-prod
```

To stop production:

```bash
make down-prod
```

The application can then be opened at:

```text
http://localhost:5000
```

Expected `/status` response in production:

```json
{
  "cache": "connected",
  "database": "connected",
  "web": "connected"
}
```

---

## 8. Makefile automation

The project includes a `Makefile` to simplify Docker commands.

Available commands:

```bash
make build
make up-dev
make up-prod
make down-dev
make down-prod
make down
make status-dev
make status-prod
```

### Build

Build both environments:

```bash
make build
```

### Development

Start development:

```bash
make up-dev
```

Stop development:

```bash
make down-dev
```

Check development:

```bash
make status-dev
```

### Production

Start production:

```bash
make up-prod
```

Stop production:

```bash
make down-prod
```

Check production:

```bash
make status-prod
```

### Stop everything

```bash
make down
```

---

## 9. Automatic presentation demo

The project includes a script that automatically starts the production environment and executes the most important tests.

Run:

```bash
./scripts/test-demo.sh
```

The script automatically:

1. Loads `config/.env.prod`.
2. Starts the production Docker environment.
3. Waits until the Flask service responds.
4. Displays the running containers.
5. Tests the `/status` endpoint.
6. Tests the `/players` endpoint.
7. Tests the `/teams` endpoint.
8. Checks the number of players stored in MySQL.
9. Checks the number of teams stored in MySQL.
10. Clears the Redis cache.
11. Executes a first request to demonstrate a cache MISS.
12. Executes a second request to demonstrate a cache HIT.
13. Displays the Redis keys.

Example:

```text
[3/8] Containers
web     Up
db      Up
cache   Up

[4/8] Health endpoint
PASS - /status

[5/8] Application data
PASS - /players
Players returned: 46

PASS - /teams
Teams returned: 17

[6/8] Database data
total_players
46

total_teams
17

[7/8] Redis cache demonstration

Request 1
  source: database
  cache: MISS

Request 2
  source: cache
  cache: HIT

[8/8] Redis keys
teams
```

The response time may vary depending on the virtual machine and host workload.

The important behaviour is:

```text
MISS -> MySQL
HIT  -> Redis
```

Redis therefore prevents unnecessary repeated database queries while the cached value is valid.

---

## 10. Stop the automatic demo

To stop the complete production environment:

```bash
./scripts/stop-demo.sh
```

This automatically loads the production configuration and executes Docker Compose `down`.

The database volume is not removed, so the MySQL data persists.

---

## 11. Web application

The application is implemented using Flask.

The main frontend is available at:

```text
/
```

The interface displays:

- Web service status
- Database status
- Cache status
- Players
- Player images
- Player team
- Player position
- Player element
- Player special moves
- Team colors
- Team crests
- Team filter
- Teams table
- Data source
- Cache HIT/MISS
- Load time
- Cache TTL

The frontend obtains the data dynamically from the Flask API.

---

## 12. Players

The application currently contains:

```text
46 players
```

Player information is stored in MySQL.

Each player contains:

- Name
- Team
- Position
- Element
- Best move 1
- Best move 2
- Image path

The frontend obtains this information from the `/players` endpoint.

Example:

```text
Name: Mark Evans
Team: Raimon
Position: Goalkeeper
Element: Mountain
Move 1: God Hand
Move 2: Majin The Hand
```

Player images are stored in:

```text
app/static/images/
```

---

## 13. Teams

The database currently contains:

```text
17 teams
```

Each team includes:

- Name
- Season/category
- School or country

Team data is displayed in the frontend.

The frontend also uses different colors and crests depending on the selected team.

Team crests are stored in:

```text
app/static/images/teams/
```

---

## 14. API endpoints

The Flask application provides several endpoints.

### `/`

Main frontend.

```text
http://localhost:5000/
```

### `/status`

Displays the state of the application and its dependencies.

```text
http://localhost:5000/status
```

Production example:

```json
{
  "cache": "connected",
  "database": "connected",
  "web": "connected"
}
```

Development example:

```json
{
  "cache": "not configured",
  "database": "connected",
  "web": "connected"
}
```

If a dependency stops responding, its state changes dynamically.

### `/players`

Returns the player data stored in MySQL.

```text
http://localhost:5000/players
```

Example structure:

```json
{
  "players": [
    {
      "id": 12,
      "name": "Mark Evans",
      "position": "Goalkeeper",
      "element": "Mountain",
      "best_move_1": "God Hand",
      "best_move_2": "Majin The Hand",
      "image_path": "/static/images/mark-evans.jpg",
      "team": "Raimon"
    }
  ]
}
```

### `/teams`

Returns the team information.

```text
http://localhost:5000/teams
```

In production this endpoint uses Redis.

Database response example:

```json
{
  "source": "database",
  "cache": "MISS",
  "load_time_ms": 4.0,
  "teams": []
}
```

Redis response example:

```json
{
  "source": "cache",
  "cache": "HIT",
  "load_time_ms": 3.0,
  "teams": []
}
```

---

## 15. Redis cache

Redis is enabled only in production.

The application caches the result of the `/teams` endpoint.

Cache key:

```text
teams
```

Cache TTL:

```text
60 seconds
```

When the cache is empty:

```text
source: database
cache: MISS
```

The application reads the data from MySQL and stores it in Redis.

A second request while the cached value is valid returns:

```text
source: cache
cache: HIT
```

This demonstrates that Redis is actually being used by the application.

The frontend also displays:

```text
Data source
Cache status
Load time
Cache TTL
```

This makes the cache behaviour visible during the presentation.

---

## 16. Database

MySQL stores the application data.

The database initialization file is:

```text
db/init.sql
```

It is mounted automatically inside the MySQL container at:

```text
/docker-entrypoint-initdb.d/init.sql
```

Therefore MySQL initializes the schema and initial data automatically when a new database volume is created.

The current initial data contains:

```text
17 teams
46 players
46 player image paths
```

---

## 17. Clean database initialization test

The database was tested using a completely new Docker project and a new Docker volume.

A temporary project was created:

```bash
docker-compose -p practica1_fresh -f docker-compose.prod.yml up -d db
```

The database was then queried:

```sql
SELECT COUNT(*) AS total_players FROM players;
SELECT COUNT(*) AS total_teams FROM teams;
SELECT COUNT(*) AS players_with_image
FROM players
WHERE image_path IS NOT NULL;
```

Result:

```text
total_players
46

total_teams
17

players_with_image
46
```

This demonstrates that `db/init.sql` can create the complete database correctly from scratch.

The temporary environment was removed using:

```bash
docker-compose -p practica1_fresh -f docker-compose.prod.yml down -v
```

---

## 18. Database persistence

MySQL uses named Docker volumes.

This allows the database to survive the deletion and recreation of its container.

The persistence test was performed in development.

Before removing the database container:

```text
before_restart
46
```

The database container was stopped:

```bash
docker-compose -p practica1_dev -f docker-compose.dev.yml stop db
```

The container was removed:

```bash
docker-compose -p practica1_dev -f docker-compose.dev.yml rm -f db
```

The database container was recreated:

```bash
docker-compose -p practica1_dev -f docker-compose.dev.yml up -d db
```

The database was queried again:

```text
after_restart
46
```

Result:

```text
before_restart = 46
after_restart  = 46
```

The data therefore persisted even though the MySQL container was removed and recreated.

---

## 19. Docker networking

The containers communicate through an internal Docker network.

Development network:

```text
practica1dev_internal_net
```

Production network:

```text
practica1prod_internal_net
```

Docker service names are used for internal communication.

Examples:

```text
web -> db
web -> cache
```

The application does not connect to MySQL using `localhost`.

Instead it uses:

```text
MYSQL_HOST=db
```

Production Redis uses:

```text
REDIS_HOST=cache
```

---

## 20. Published ports

Only the Flask web application publishes a port to the host.

Example:

```text
0.0.0.0:5000 -> 5000/tcp
```

MySQL does not expose port `3306` to the host.

Redis does not expose port `6379` to the host.

They are accessible only inside the Docker network.

This reduces unnecessary external exposure.

---

## 21. Healthchecks

Every service includes a healthcheck.

### Flask

The Flask Docker image checks:

```text
http://localhost:5000/status
```

Dockerfile configuration:

```text
HEALTHCHECK --interval=30s --timeout=3s --retries=3
```

The check uses Python `urllib` to access `/status`.

### MySQL

The MySQL container uses:

```text
mysqladmin ping
```

This verifies that the database server is responding.

### Redis

The Redis container uses:

```text
redis-cli ping
```

A healthy Redis server responds with:

```text
PONG
```

---

## 22. Dynamic service status

The frontend shows the connection status of the dependencies.

In production:

```text
Web       connected
Database  connected
Cache     connected
```

In development:

```text
Web       connected
Database  connected
Cache     not configured
```

If the database or cache becomes unavailable, the `/status` endpoint reflects the change dynamically.

---

## 23. Security

The project implements several basic security measures.

### Environment variables

Credentials are not hardcoded inside the application.

They are provided using environment variables.

Examples:

```text
MYSQL_USER
MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD
MYSQL_DATABASE
REDIS_HOST
REDIS_PORT
```

### Git protection

Real `.env` files are ignored using `.gitignore`.

Only example configuration files are included in the repository.

### Internal services

MySQL and Redis are not exposed to the host.

Only the Flask application exposes a public port.

### Non-root Flask container

The Flask application runs using a dedicated non-root user:

```text
appuser
```

The Dockerfile creates this user and changes ownership of the application files.

Verification:

```bash
docker-compose -p practica1_prod -f docker-compose.prod.yml exec web id
```

Result:

```text
uid=1000(appuser) gid=1000(appuser) groups=1000(appuser)
```

Therefore the web application does not run as `root`.

---

## 24. Development and production comparison

| Feature | Development | Production |
|---|---|---|
| Flask | Yes | Yes |
| MySQL | Yes | Yes |
| Redis | No | Yes |
| Internal Docker network | Yes | Yes |
| Persistent MySQL volume | Yes | Yes |
| Web published | Yes | Yes |
| MySQL published | No | No |
| Redis published | No | No |
| Web healthcheck | Yes | Yes |
| MySQL healthcheck | Yes | Yes |
| Redis healthcheck | Not applicable | Yes |
| Cache state | Not configured | Connected |
| Redis cache usage | No | Yes |
| `/players` | Yes | Yes |
| `/teams` | Yes | Yes |
| `/status` | Yes | Yes |

---

## 25. Final verification results

The project was tested before delivery.

### Production

```text
web: connected
database: connected
cache: connected
```

### Players API

```text
Players returned: 46
```

### Teams API

```text
Teams returned: 17
```

### Clean database initialization

```text
total_players: 46
total_teams: 17
players_with_image: 46
```

### Development

```text
web: connected
database: connected
cache: not configured
```

### Persistence

```text
before_restart: 46
after_restart: 46
```

### Redis

```text
Request 1
source: database
cache: MISS

Request 2
source: cache
cache: HIT
```

### Non-root web service

```text
uid=1000(appuser)
gid=1000(appuser)
```

---

## 26. Recommended presentation workflow

For the practical presentation, first enter the project directory:

```bash
cd /media/sf_RedesAvanzadas/Practicas/Practica1
```

Run:

```bash
./scripts/test-demo.sh
```

The script starts production and runs the automatic verification.

Then open:

```text
http://localhost:5000
```

The frontend can be used to demonstrate:

- Players loaded from MySQL
- Teams loaded from MySQL
- Player images
- Team colors
- Team crests
- Service status
- Redis status
- Cache HIT/MISS
- Load time

To demonstrate Redis manually, clear the cache:

```bash
docker-compose -p practica1_prod -f docker-compose.prod.yml exec cache redis-cli FLUSHDB
```

Reload the page.

The first `/teams` request should display:

```text
Data source: MySQL
Cache status: MISS
```

Reload again.

The next request should display:

```text
Data source: Redis
Cache status: HIT
```

Finally stop the environment:

```bash
./scripts/stop-demo.sh
```

---

## 27. Git repository

The project is managed using Git.

Development was performed incrementally using small commits for:

- Initial project structure
- Docker configuration
- MySQL integration
- Redis integration
- Healthchecks
- Players API
- Frontend
- Images
- Team colors
- Team crests
- Database changes
- Cache metrics
- Demo automation
- Security improvements

The complete project is published in a public GitHub repository.

---

## 28. Artificial Intelligence disclosure

Artificial intelligence was used during development of this project.

### Tool

OpenAI ChatGPT

### Model

GPT-5.6 Sol

### Purpose

AI assistance was used for:

- Docker configuration
- Docker Compose configuration
- Flask development
- MySQL database design
- Redis integration
- Debugging
- Healthcheck configuration
- Bash scripts
- Testing
- Frontend improvements
- Documentation
- Git workflow assistance

### Applied parts

AI assistance was used to propose commands, configuration changes, code snippets, tests and explanations during development.

All resulting commands, configurations and application behaviour were executed, checked and tested by the student before inclusion in the final project.

---

## 29. Conclusion

The project implements a complete multi-container Docker application with separate development and production environments.

The final system includes:

- Flask web application
- MySQL database
- Redis production cache
- Two Docker Compose environments
- Internal networking
- Persistent database storage
- Automatic database initialization
- Healthchecks
- Dynamic service status
- Redis cache demonstration
- Cache performance information
- Environment variables
- Non-root web execution
- Makefile automation
- Bash automation scripts
- Automated presentation tests
- Web frontend using real database data
- 46 players
- 17 teams
- Player images
- Team crests

The development environment runs without Redis, while the production environment uses Redis to cache team information.

Database persistence, fresh initialization, healthchecks, internal networking and cache behaviour have all been tested successfully.
