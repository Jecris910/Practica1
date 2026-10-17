DEV_PROJECT=practica1_dev
PROD_PROJECT=practica1_prod

build:
	set -a && . ./config/.env.dev && set +a && \
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml build
	set -a && . ./config/.env.prod && set +a && \
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml build

up-dev:
	set -a && . ./config/.env.dev && set +a && \
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml up -d

up-prod:
	set -a && . ./config/.env.prod && set +a && \
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml up -d

down-dev:
	set -a && . ./config/.env.dev && set +a && \
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml down

down-prod:
	set -a && . ./config/.env.prod && set +a && \
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml down

down: down-dev down-prod

status-dev:
	set -a && . ./config/.env.dev && set +a && \
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml ps

status-prod:
	set -a && . ./config/.env.prod && set +a && \
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml ps
