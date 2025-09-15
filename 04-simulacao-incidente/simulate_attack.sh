#!/bin/bash
# Simula tráfego normal e um payload simples de SQL injection contra a app local

for i in {1..5}; do
  curl -s "http://localhost:8080/search?q=normal+$i" >/dev/null
done

# payload de injeção (simples)
curl -s "http://localhost:8080/search?q=' OR '1'='1" >/dev/null

echo "Simulação finalizada. Verifique 02-seguranca-containers/app.log"