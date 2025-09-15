# ---------- Builder stage: build wheels ----------
FROM python:3.11-slim AS builder
WORKDIR /build

# System deps only for building wheels (not kept in final image)
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential gcc \
  && rm -rf /var/lib/apt/lists/*

# Copy and build wheels
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels

# ---------- Final stage ----------
FROM python:3.11-slim

# Helpful runtime envs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user
RUN useradd -m -u 10001 appuser

WORKDIR /app

# Install dependencies from prebuilt wheels
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir /wheels/* \
    && rm -rf /wheels

# App source
COPY app.py .
# (Optional) keep for reference; not used at runtime
COPY requirements.txt .

# Ensure log file exists and is writable by appuser
RUN touch /app/app.log && chown appuser:appuser /app/app.log

USER appuser

EXPOSE 8080

# -u keeps Python unbuffered; pairs well with log shipping/Promtail
CMD ["python", "-u", "app.py"]