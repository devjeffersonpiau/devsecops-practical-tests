#!/bin/bash
# Exemplo de uso via docker exec (não requer vault CLI local)
docker-compose up -d
CID=$(docker ps -qf "ancestor=vault:1.14.0")
if [ -z "$CID" ]; then
  echo "Não encontrei container do Vault. Verifique 'docker ps'."
  exit 1
fi
docker exec -it $CID vault kv put secret/devapp DATABASE_PASSWORD='SuperSecret123'
docker exec -it $CID vault kv get secret/devapp
