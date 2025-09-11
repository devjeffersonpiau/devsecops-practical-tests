# Multi-stage Dockerfile - Python Flask app
FROM python:3.11-slim AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y build-essential gcc --no-install-recommends && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels

FROM python:3.11-slim
RUN useradd -m appuser
WORKDIR /app
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir /wheels/*
COPY app.py .
COPY requirements.txt .
USER appuser
EXPOSE 8080
CMD ["python", "app.py"]