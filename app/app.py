from flask import Flask, jsonify
import os
import pymysql

app = Flask(__name__)

def check_database():
    try:
        connection = pymysql.connect(
            host=os.getenv("MYSQL_HOST"),
            port=int(os.getenv("MYSQL_PORT", "3306")),
            user=os.getenv("MYSQL_USER"),
            password=os.getenv("MYSQL_PASSWORD"),
            database=os.getenv("MYSQL_DATABASE"),
            connect_timeout=2
        )
        connection.close()
        return "connected"
    except Exception:
        return "disconnected"

@app.route("/")
def home():
    return "Practica 1 - Multi-environment deployment"

@app.route("/status")
def status():
    return jsonify({
        "web": "connected",
        "database": check_database()
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, threaded=False)
