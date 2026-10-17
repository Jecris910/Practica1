#!/bin/bash

set -u

PROJECT="practica1_prod"
COMPOSE="docker-compose.prod.yml"
ENV_FILE="config/.env.prod"

if [ -f "$ENV_FILE" ]; then
    set -a
    . "$ENV_FILE"
    set +a
fi

echo "Stopping production environment..."

docker-compose -p "$PROJECT" -f "$COMPOSE" down

echo "Production environment stopped."
