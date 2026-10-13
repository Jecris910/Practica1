from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Practica 1 - Multi-environment deployment"

@app.route("/status")
def status():
    return jsonify({"web": "connected"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, threaded=False)
