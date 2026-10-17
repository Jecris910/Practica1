#!/bin/bash

set -u

PROJECT="practica1_prod"
COMPOSE="docker-compose.prod.yml"
ENV_FILE="config/.env.prod"

echo "========================================"
echo " Practica 1 - Automated Demo"
echo "========================================"
echo ""

echo "[0/8] Loading production environment"

if [ ! -f "$ENV_FILE" ]; then
    echo "FAIL - $ENV_FILE not found"
    exit 1
fi

set -a
. "$ENV_FILE"
set +a

BASE_URL="http://localhost:${WEB_PORT:-5000}"

echo "PASS - Environment loaded"
echo ""

echo "[1/8] Starting Docker environment"

docker-compose -p "$PROJECT" -f "$COMPOSE" up -d

if [ $? -ne 0 ]; then
    echo "FAIL - Docker environment could not be started"
    exit 1
fi

echo "PASS - Docker environment started"
echo ""

echo "[2/8] Waiting for web service"

ATTEMPTS=0
MAX_ATTEMPTS=30

while true; do
    if python3 - <<PY >/dev/null 2>&1
import urllib.request
urllib.request.urlopen("${BASE_URL}/status", timeout=2)
PY
    then
        echo "PASS - Web service is ready"
        break
    fi

    ATTEMPTS=$((ATTEMPTS + 1))

    if [ "$ATTEMPTS" -ge "$MAX_ATTEMPTS" ]; then
        echo "FAIL - Web service did not become ready"
        exit 1
    fi

    echo "Waiting..."
    sleep 2
done

echo ""
echo "[3/8] Containers"

docker-compose -p "$PROJECT" -f "$COMPOSE" ps

echo ""
echo "[4/8] Health endpoint"

python3 - <<PY
import urllib.request
import json

url = "${BASE_URL}/status"

try:
    response = urllib.request.urlopen(url)
    data = json.loads(response.read().decode())

    print("PASS - /status")
    print(json.dumps(data, indent=2))
except Exception as e:
    print("FAIL - /status")
    print(e)
PY

echo ""
echo "[5/8] Application data"

python3 - <<PY
import urllib.request
import json

for endpoint in ("players", "teams"):
    try:
        response = urllib.request.urlopen("${BASE_URL}/" + endpoint)
        data = json.loads(response.read().decode())

        values = data.get(endpoint, [])

        print("PASS - /{}".format(endpoint))
        print("{} returned: {}".format(
            endpoint.capitalize(),
            len(values)
        ))

    except Exception as e:
        print("FAIL - /{}".format(endpoint))
        print(e)
PY

echo ""
echo "[6/8] Database data"

docker-compose -p "$PROJECT" -f "$COMPOSE" exec -T db \
mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" \
-e "
SELECT COUNT(*) AS total_players FROM players;
SELECT COUNT(*) AS total_teams FROM teams;
"

echo ""
echo "[7/8] Redis cache demonstration"

docker-compose -p "$PROJECT" -f "$COMPOSE" exec -T cache \
redis-cli FLUSHDB > /dev/null

python3 - <<PY
import urllib.request
import json
import time

url = "${BASE_URL}/teams"

for i in range(1, 3):
    response = urllib.request.urlopen(url)
    data = json.loads(response.read().decode())

    print("Request {}".format(i))
    print("  source: {}".format(data.get("source")))
    print("  cache: {}".format(data.get("cache")))
    print("  load_time_ms: {}".format(data.get("load_time_ms")))
    print()

    time.sleep(1)
PY

echo "[8/8] Redis keys"

docker-compose -p "$PROJECT" -f "$COMPOSE" exec -T cache \
redis-cli KEYS '*'

echo ""
echo "========================================"
echo " Demo completed successfully"
echo " Open: $BASE_URL"
echo "========================================"
