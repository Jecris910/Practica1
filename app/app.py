from flask import Flask, jsonify, render_template
import json
import os
import pymysql
import redis

app = Flask(__name__)

def get_database_connection():
    return pymysql.connect(
        host=os.getenv("MYSQL_HOST"),
        port=int(os.getenv("MYSQL_PORT", "3306")),
        user=os.getenv("MYSQL_USER"),
        password=os.getenv("MYSQL_PASSWORD"),
        database=os.getenv("MYSQL_DATABASE"),
        connect_timeout=2,
        cursorclass=pymysql.cursors.DictCursor
    )

def get_cache_connection():
    redis_host = os.getenv("REDIS_HOST")

    if not redis_host:
        return None

    return redis.Redis(
        host=redis_host,
        port=int(os.getenv("REDIS_PORT", "6379")),
        socket_connect_timeout=2,
        decode_responses=True
    )

def check_database():
    try:
        connection = get_database_connection()
        connection.close()
        return "connected"
    except Exception:
        return "disconnected"

def check_cache():
    try:
        cache = get_cache_connection()

        if cache is None:
            return "not configured"

        cache.ping()
        return "connected"
    except Exception:
        return "disconnected"

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/status")
def status():
    return jsonify({
        "web": "connected",
        "database": check_database(),
        "cache": check_cache()
    })


@app.route("/players")
def players():
    try:
        connection = get_database_connection()

        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT
                    p.id,
                    p.name,
                    p.position,
                    p.element,
                    p.best_move_1,
                    p.best_move_2,
                    p.image_path,
                    t.name AS team
                FROM players p
                JOIN teams t ON p.team_id = t.id
                ORDER BY t.id, p.id
            """)
            players_data = cursor.fetchall()

        connection.close()

        return jsonify({
            "players": players_data
        })

    except Exception:
        return jsonify({
            "error": "database unavailable"
        }), 503

@app.route("/teams")
def teams():
    cache = None

    try:
        cache = get_cache_connection()

        if cache is not None:
            cached_teams = cache.get("teams")

            if cached_teams:
                return jsonify({
                    "source": "cache",
                    "teams": json.loads(cached_teams)
                })
    except Exception:
        cache = None

    try:
        connection = get_database_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT id, name, category, school_or_country FROM teams"
            )
            teams_data = cursor.fetchall()

        connection.close()

        if cache is not None:
            try:
                cache.setex(
                    "teams",
                    60,
                    json.dumps(teams_data)
                )
            except Exception:
                pass

        return jsonify({
            "source": "database",
            "teams": teams_data
        })

    except Exception:
        return jsonify({
            "error": "database unavailable"
        }), 503

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, threaded=False)
