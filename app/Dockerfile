FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --progress-bar off -r requirements.txt

COPY app.py .
COPY templates ./templates
COPY static ./static

RUN useradd --create-home --shell /usr/sbin/nologin appuser &&     chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/status')"
CMD ["python", "app.py"]
