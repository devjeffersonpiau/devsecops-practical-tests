# DevSecOps Practical Tests - Starter Repository

# DevSecOps Practical Tests

Este repositório contém a implementação dos **5 desafios práticos** do teste técnico de DevSecOps.  
Cada pasta tem código, Dockerfiles, exemplos de IaC e instruções específicas em seu próprio `README.md`.

---

## 📂 Estrutura

- **01-ci-cd-pipeline-seguro**  
  ➤ Pipeline CI/CD rodando em **GitHub Actions**, com:
  - Unit tests (pytest)  
  - Análise estática e segurança: **SonarQube**  
  - Escaneamento de dependências: **OWASP Dependency-Check**  
  - Escaneamento de imagem Docker: **Trivy (falha em vulnerabilidades CRITICAL)**  

- **02-seguranca-containers**  
  ➤ Aplicação simples em Python/Flask com:
  - Dockerfile seguro (multi-stage build, usuário não-root, base mínima)  
  - Testes automatizados com pytest  
  - Escaneamento de imagem Docker com Trivy  

- **03-iac-com-validacoes**  
  ➤ Exemplo de IaC (Terraform) com validações de segurança usando Checkov/TFSec.  

- **04-simulacao-incidente**  
  ➤ Simulação de ataque simples (injeção SQL) + script de detecção e monitoramento.  

- **05-gestao-segredos**  
  ➤ Exemplo de gestão de segredos usando HashiCorp Vault (docker-compose).  

---

## 🚀 CI/CD Pipeline (GitHub Actions)

O workflow principal está em [`.github/workflows/ci.yml`](.github/workflows/ci.yml).  
Ele executa automaticamente em **cada push ou pull request**:

1. **Unit tests**  
   - Executa pytest no desafio 02.  
   - Verifica se a aplicação está funcional.  

2. **Build + Trivy**  
   - Constrói a imagem Docker.  
   - Escaneia com **Trivy**.  
   - O job **falha** caso haja vulnerabilidades **CRITICAL**.  

3. **OWASP Dependency-Check**  
   - Escaneia dependências da aplicação.  
   - Publica relatório em SARIF no GitHub Security.  
   - Relatórios também ficam disponíveis como artifact para download.  

4. **SonarQube (condicional)**  
   - Executa análise estática no SonarQube apenas se os secrets `SONAR_TOKEN` e `SONAR_HOST_URL` estiverem configurados.  

---

## 📊 Como validar no GitHub Actions (gestor)

1. Vá até a aba **Actions** deste repositório.  
2. Clique no último run de `ci-cd-security`.  
3. Confira os jobs:
   - ✅ **Unit tests (pytest)** deve passar.  
   - ✅ **Build Docker & Trivy**: se houver CRITICAL, o job falha → comportamento esperado.  
   - ✅ **OWASP Dependency-Check**: gera relatórios e envia para *Code scanning alerts*.  
   - ✅ **SonarQube**: roda apenas se secrets estiverem configurados.  

4. Relatórios:  
   - Vá em **Artifacts** (no run) → baixe `dependency-check-reports`.  
   - Vá em **Security → Code scanning alerts** para ver vulnerabilidades reportadas.  

---

## 🔑 Secrets utilizados

- `SONAR_HOST_URL` → URL do SonarQube/SonarCloud  
- `SONAR_TOKEN` → Token de autenticação Sonar  
- `NVD_API_KEY` → Chave para consultas à base da NVD (Dependency-Check)  

---

## ✅ Como rodar localmente

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
