# 02 - Segurança em Containers

Objetivo:
- Criar imagem Docker segura (multi-stage, usuário não-root) e escanear com Trivy.

Como testar:
- python -m venv .venv && source .venv/bin/activate
- pip install -r requirements.txt
- pytest
- docker build -t devsecops-app .
- trivy image --exit-code 1 --severity CRITICAL devsecops-app:latest
