# 05 - Gestão de Segredos

Objetivo:
- Demonstrar armazenamento e recuperação de segredos (Vault / AWS Secrets Manager / Doppler).

Como testar (Vault dev):
- docker-compose up -d
- export VAULT_ADDR='http://127.0.0.1:8200'
- export VAULT_TOKEN='root-token'
- vault kv put secret/devapp DATABASE_PASSWORD='SuperSecret123'
