DEV_PROJECT=practica1_dev
PROD_PROJECT=practica1_prod

build:
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml build
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml build

up-dev:
	set -a && . ./config/.env.dev && set +a && \
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml up -d

up-prod:
	set -a && . ./config/.env.prod && set +a && \
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml up -d

down-dev:
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml down

down-prod:
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml down

down: down-dev down-prod

status-dev:
	docker-compose -p $(DEV_PROJECT) -f docker-compose.dev.yml ps

status-prod:
	docker-compose -p $(PROD_PROJECT) -f docker-compose.prod.yml ps
