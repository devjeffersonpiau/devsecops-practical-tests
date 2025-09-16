# DevSecOps Practical Tests

Este repositório contém a implementação dos 5 desafios práticos do teste técnico de DevSecOps.  
Cada pasta possui código, Dockerfiles, exemplos de IaC e instruções específicas em seu próprio `README.md`.

---

## Estrutura

**01-ci-cd-pipeline-seguro**  
Pipeline CI/CD rodando em GitHub Actions, com:  
- Unit tests com `pytest`  
- Análise estática e segurança com [SonarCloud](https://sonarcloud.io/projects)  
- Escaneamento de dependências com [OWASP Dependency-Check](https://jeremylong.github.io/DependencyCheck/)  
- Escaneamento de imagem Docker com [Trivy](https://aquasecurity.github.io/trivy/), configurado para falhar em vulnerabilidades **CRITICAL**

**02-seguranca-containers**  
Aplicação simples em Python/Flask com:  
- Dockerfile seguro (multi-stage build, usuário não-root, base mínima)  
- Testes automatizados com `pytest`  
- Escaneamento de imagem Docker com Trivy  

**03-iac-com-validacoes**  
Exemplo de IaC (Terraform) com validações de segurança usando [Checkov](https://www.checkov.io/) e [tfsec](https://aquasecurity.github.io/tfsec/).  

**04-simulacao-incidente**  
Simulação de ataque simples (injeção SQL) e script de detecção/monitoramento.  
Cenário integrável com observabilidade ([Grafana Loki](https://grafana.com/oss/loki/), [Prometheus](https://prometheus.io/)).  

**05-gestao-segredos**  
Exemplo de gestão de segredos utilizando [HashiCorp Vault](https://www.vaultproject.io/).  

---

## CI/CD Pipeline (GitHub Actions)

O workflow principal está em [`.github/workflows/ci.yml`](.github/workflows/ci.yml).  
Ele é executado automaticamente a cada **push** ou **pull request**.

### Etapas principais

- **Unit tests**  
  Executa `pytest` no desafio 02 e valida se a aplicação está funcional.

- **Build + Trivy**  
  Constrói a imagem Docker.  
  Escaneia com Trivy.  
  O job falha caso sejam encontradas vulnerabilidades **CRITICAL**.

- **OWASP Dependency-Check**  
  Escaneia dependências da aplicação.  
  Publica relatório em formato SARIF no GitHub Security.  
  Relatórios adicionais ficam disponíveis como artifact.  

- **SonarQube (condicional)**  
  Executa análise estática no [SonarCloud](https://sonarcloud.io/projects) somente se os secrets `SONAR_TOKEN` e `SONAR_HOST_URL` estiverem configurados.

---

## Como validar no GitHub Actions

1. Acesse a aba [**Actions**](https://github.com/devjeffersonpiau/devsecops-practical-tests/actions) do repositório.  
2. Clique no último run do workflow **ci-cd-security**.  
3. Confira os jobs:
   - Unit tests (pytest) deve **passar**.  
   - Build + Trivy: falha em vulnerabilidades **CRITICAL** (comportamento esperado).  
   - OWASP Dependency-Check: gera relatórios e envia para [Code scanning alerts](https://github.com/devjeffersonpiau/devsecops-practical-tests/security/code-scanning).  
   - SonarQube: executa apenas se os secrets estiverem configurados.  

**Relatórios disponíveis**:  
- [Artifacts](https://github.com/devjeffersonpiau/devsecops-practical-tests/actions) do run (para baixar `dependency-check-reports`).  
- [Code scanning alerts](https://github.com/devjeffersonpiau/devsecops-practical-tests/security/code-scanning).  
- [SonarCloud](https://sonarcloud.io/projects) (secrets configurados).  

---

## Secrets utilizados

- **SONAR_HOST_URL** → URL do SonarQube/SonarCloud  
- **SONAR_TOKEN** → Token de autenticação Sonar  
- **NVD_API_KEY** → Chave para consultas à base da NVD (Dependency-Check)  

---

## Como rodar localmente

```bash
cd 02-seguranca-containers

# ativar virtualenv
python3 -m venv .venv
source .venv/bin/activate

# instalar dependências
pip install -r requirements.txt

# rodar testes
pytest -q

# build docker
docker build -t devsecops-app .

# rodar app
docker run --rm -p 8081:8080 devsecops-app

# testar endpoints
curl http://localhost:8081/
curl "http://localhost:8081/search?q=teste"

Diferenciais

Pipeline CI/CD com segurança aplicada desde o início (Shift Left Security)

Escaneamento automatizado em código, dependências e imagens Docker

Simulação de incidentes para validar monitoramento

Gestão de segredos integrada com Vault

Preparado para observabilidade e dashboards no Grafana/Prometheus
