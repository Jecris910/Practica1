#!/bin/bash

set -u

PROJECT="practica1_prod"
COMPOSE="docker-compose.prod.yml"
BASE_URL="http://localhost:${WEB_PORT:-5000}"

echo "========================================"
echo " Practica 1 - Automated Demo Tests"
echo "========================================"
echo ""

echo "[1/7] Containers"
docker-compose -p "$PROJECT" -f "$COMPOSE" ps
echo ""

echo "[2/7] Health endpoint"
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
echo "[3/7] Players API"

python3 - <<PY
import urllib.request
import json

url = "${BASE_URL}/players"

try:
    response = urllib.request.urlopen(url)
    data = json.loads(response.read().decode())
    players = data.get("players", [])
    print("PASS - /players")
    print("Players returned:", len(players))
except Exception as e:
    print("FAIL - /players")
    print(e)
PY

echo ""
echo "[4/7] Teams API"

python3 - <<PY
import urllib.request
import json

url = "${BASE_URL}/teams"

try:
    response = urllib.request.urlopen(url)
    data = json.loads(response.read().decode())
    teams = data.get("teams", [])
    print("PASS - /teams")
    print("Teams returned:", len(teams))
except Exception as e:
    print("FAIL - /teams")
    print(e)
PY

echo ""
echo "[5/7] Database persistence"

docker-compose -p "$PROJECT" -f "$COMPOSE" exec -T db \
mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" \
-e "
SELECT COUNT(*) AS total_players FROM players;
SELECT COUNT(*) AS total_teams FROM teams;
"

echo ""
echo "[6/7] Redis cache test"

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

    print("Request", i)
    print("  source:", data.get("source"))
    print("  cache:", data.get("cache"))
    print("  load_time_ms:", data.get("load_time_ms"))
    print()

    time.sleep(1)
PY

echo ""
echo "[7/7] Redis keys"

docker-compose -p "$PROJECT" -f "$COMPOSE" exec -T cache \
redis-cli KEYS '*'

echo ""
echo "========================================"
echo " Demo tests completed"
echo "========================================"
