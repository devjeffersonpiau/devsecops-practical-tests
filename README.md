DevSecOps Practical Tests - Starter Repository

Este repositório contém a implementação dos 5 desafios práticos do teste técnico de DevSecOps.
Cada pasta possui código, Dockerfiles, exemplos de IaC e instruções específicas em seu próprio README.md.

Estrutura

01-ci-cd-pipeline-seguro

Pipeline CI/CD rodando em GitHub Actions, com:

Unit tests com pytest

Análise estática e segurança com SonarCloud

Escaneamento de dependências com OWASP Dependency-Check

Escaneamento de imagem Docker com Trivy (falha em vulnerabilidades CRITICAL)

02-seguranca-containers

Aplicação simples em Python/Flask com:

Dockerfile seguro (multi-stage build, usuário não-root, base mínima)

Testes automatizados com pytest

Escaneamento de imagem Docker com Trivy

03-iac-com-validacoes

Exemplo de IaC (Terraform) com validações de segurança usando Checkove tfsec.

04-simulacao-incidente

Simulação de ataque simples (injeção SQL) + script de detecção e monitoramento.

Cenário integrável com observabilidade usando Grafana,Loki e Prometheus.


05-gestao-segredos

Exemplo de gestão de segredos usando HashiCorp Vault (docker-compose).

CI/CD Pipeline (GitHub Actions)

O workflow principal está em .github/workflows/ci.yml.

Ele executa automaticamente em cada push ou pull request:

Unit tests

Executa pytest no desafio 02.

Verifica se a aplicação está funcional.

Build + Trivy

Constrói a imagem Docker.

Escaneia com Trivy.

O job falha caso haja vulnerabilidades CRITICAL.

OWASP Dependency-Check

Escaneia dependências da aplicação.

Publica relatório em formato SARIF no GitHub Security.


Relatórios também ficam disponíveis como artifact para download.

SonarQube (condicional)

Executa análise estática no SonarCloud apenas se os secrets SONAR_TOKEN e SONAR_HOST_URL estiverem configurados.

Como validar no GitHub Actions

Acesse a aba Actions.

Clique no último run do workflow ci-cd-security.

Confira os jobs:

✅ Unit tests (pytest) deve passar.

✅ Build Docker & Trivy: falha em vulnerabilidades CRITICAL (comportamento esperado).

✅ OWASP Dependency-Check: gera relatórios e envia para Code scanning alerts.

✅ SonarQube: roda apenas se os secrets estiverem configurados.

Relatórios disponíveis:

Artifacts do run (para baixar dependency-check-reports).

Code scanning alerts.

SonarCloud Projects.

Secrets utilizados

SONAR_HOST_URL → URL do SonarCloud

SONAR_TOKEN → Token de autenticação do Sonar

NVD_API_KEY → Chave para consultas à base da NVD (Dependency-Check)

Como rodar localmente

cd 02-seguranca-containers

# ativar virtualenv

python3 -m venv 
.venv source .venv/bin/activate

# instalar dependências

pip install -r requirements.txt

# rodar testes

pytest -q

# build docker

docker build -t devsecops-app.

# rodar app

docker run --rm -p 8081:8080 devsecops-app

# testar endpoints

curl http://localhost:8081/

curl "http://localhost:8081/search?q=teste"

Diferenciais

Pipeline CI/CD com segurança aplicada desde o início (Shift Left Security).

Escaneamento automatizado em código, dependências e imagens Docker.

Simulação de incidentes para validar monitoramento.

Gestão de segredos integrada com Vault.

Preparado para observabilidade e dashboards no Grafana/Prometheus.
