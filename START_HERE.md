# 🚀 COMECE AQUI - Sistema de Entrega Contínua

## 👋 Bem-vindo!

Este repositório agora possui um sistema completo de entrega contínua (CD) para o Google Play, totalmente automatizado com GitHub Actions e Fastlane.

## 📖 Documentos Principais

### 1. 📋 **[CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)** ← **COMECE POR AQUI!**
**O guia mais importante!** Contém todas as instruções passo a passo para:
- Configurar o Google Play Console
- Criar e configurar a Service Account
- Adicionar secrets no GitHub
- Criar branches (internal, beta, main)
- Fazer o primeiro deploy manual

**Tempo estimado**: 50 minutos

### 2. ✅ **[IMPLEMENTACAO_COMPLETA.md](IMPLEMENTACAO_COMPLETA.md)**
Resumo do que foi implementado:
- Lista de todos os workflows criados
- Estrutura de arquivos
- Features implementadas
- Próximos passos

### 3. 📚 **[docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)**
Documentação técnica completa:
- Arquitetura de branches
- Como funcionam os workflows
- Gerenciamento de versões
- Fastlane lanes
- Troubleshooting

### 4. ⚡ **[docs/GUIA_RAPIDO.md](docs/GUIA_RAPIDO.md)**
Referência rápida para uso diário:
- Comandos úteis
- Fluxo de trabalho do dia-a-dia
- Problemas comuns

### 5. 🏗️ **[docs/ARQUITETURA_CD.md](docs/ARQUITETURA_CD.md)**
Diagramas e arquitetura do sistema:
- Fluxos visuais
- Componentes do sistema
- Estratégia de rollout

## 🎯 Como Funciona (Resumo Rápido)

### Antes (Manual) 😓
1. Build manual do app
2. Upload manual no Play Console
3. Configuração manual de versão
4. Muito tempo e propenso a erros

### Agora (Automatizado) 🚀
1. Desenvolver feature
2. Criar Pull Request
3. Aprovar e mergear
4. **Deploy automático!** ✨

## 🔄 Fluxo de Trabalho

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   feature   │─PR──▶│  internal   │─PR──▶│    beta     │─PR──▶│    main     │
└─────────────┘      └─────────────┘      └─────────────┘      └─────────────┘
                            │                     │                     │
                            │ merge               │ merge               │ merge
                            ▼                     ▼                     ▼
                     ┌─────────────┐      ┌─────────────┐      ┌─────────────┐
                     │  Internal   │      │    Beta     │      │ Production  │
                     │   Track     │      │   Track     │      │    Track    │
                     │  (Google    │      │  (Google    │      │  (Google    │
                     │   Play)     │      │   Play)     │      │   Play)     │
                     └─────────────┘      └─────────────┘      └─────────────┘
```

## 🎬 Próximos Passos

### Passo 1: Configuração Inicial
👉 Abra e siga o **[CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)**

### Passo 2: Criar Branches
```bash
git checkout main
git checkout -b internal
git push -u origin internal

git checkout main
git checkout -b beta
git push -u origin beta
```

### Passo 3: Configurar Secrets no GitHub
No seu repositório GitHub: **Settings > Secrets and variables > Actions**

Adicione estes 5 secrets:
- `KEYSTORE_BASE64`
- `KEYSTORE_PASSWORD`
- `KEY_PASSWORD`
- `KEY_ALIAS`
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`

(Detalhes completos em [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md))

### Passo 4: Primeiro Deploy
Faça um upload manual inicial seguindo o guia.

### Passo 5: Usar o Sistema! 🎉
A partir de agora, apenas desenvolva e crie PRs!

## 📁 Estrutura do Projeto

```
santo-terco/
│
├── 📄 START_HERE.md                    ← Você está aqui!
├── 📋 CONFIGURACAO_MANUAL.md           ← Guia de setup (PRINCIPAL)
├── ✅ IMPLEMENTACAO_COMPLETA.md        ← Resumo da implementação
│
├── .github/
│   ├── workflows/
│   │   ├── ci-tests.yml               # CI para todos PRs
│   │   ├── deploy-internal.yml        # Deploy automático - Internal
│   │   ├── deploy-beta.yml            # Deploy automático - Beta
│   │   └── deploy-production.yml      # Deploy automático - Production
│   └── pull_request_template.md       # Template de PR
│
├── android/
│   ├── fastlane/
│   │   ├── Fastfile                   # Configuração Fastlane
│   │   └── Appfile                    # Config do app
│   ├── Gemfile                        # Dependências Ruby
│   └── key.properties.example         # Template de keystore
│
├── docs/
│   ├── 📚 DEPLOYMENT.md               # Documentação técnica
│   ├── ⚡ GUIA_RAPIDO.md              # Referência rápida
│   └── 🏗️ ARQUITETURA_CD.md          # Diagramas e arquitetura
│
└── README.md                          # README atualizado
```

## ⚙️ Workflows Criados

### 1. `ci-tests.yml` - CI para PRs
- **Quando**: Todo Pull Request
- **O que faz**: Testa, analisa e verifica o código

### 2. `deploy-internal.yml` - Deploy Internal
- **Quando**: PR mergeado em `internal`
- **O que faz**: Build, incrementa versão, deploy para Internal Track

### 3. `deploy-beta.yml` - Deploy Beta
- **Quando**: PR mergeado em `beta`
- **O que faz**: Build, incrementa versão, deploy para Beta Track

### 4. `deploy-production.yml` - Deploy Production
- **Quando**: PR mergeado em `main`
- **O que faz**: Build, incrementa versão, deploy para Production (10% rollout), cria GitHub Release

## 🔐 Secrets Necessários

Você precisará configurar estes 5 secrets no GitHub:

| Secret | Descrição |
|--------|-----------|
| `KEYSTORE_BASE64` | Keystore Android em base64 |
| `KEYSTORE_PASSWORD` | Senha do keystore |
| `KEY_PASSWORD` | Senha da key |
| `KEY_ALIAS` | Alias da key (geralmente "upload") |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | Credenciais do Google Cloud |

**Como configurar**: Ver seção 2 de [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)

## ✨ Features Implementadas

✅ Deploy automático para 3 tracks (Internal, Beta, Production)  
✅ Incremento automático de versão  
✅ Testes automáticos em todo PR  
✅ Verificação de código (lint + format)  
✅ Criação automática de GitHub Releases  
✅ Documentação completa em português  
✅ Templates de PR  
✅ Proteção de secrets  

## 🆘 Precisa de Ajuda?

### Para Setup Inicial
→ [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)

### Para Uso Diário
→ [docs/GUIA_RAPIDO.md](docs/GUIA_RAPIDO.md)

### Para Detalhes Técnicos
→ [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)

### Para Entender a Arquitetura
→ [docs/ARQUITETURA_CD.md](docs/ARQUITETURA_CD.md)

## 🎓 Exemplo de Uso Diário

```bash
# 1. Criar feature
git checkout internal
git pull origin internal
git checkout -b feature/nova-funcionalidade

# 2. Desenvolver
# ... escrever código ...
git add .
git commit -m "feat: adiciona nova funcionalidade"

# 3. Enviar e criar PR
git push origin feature/nova-funcionalidade
# Criar PR no GitHub para 'internal'

# 4. Após aprovação e merge
# → Deploy automático para Internal Track! 🚀

# 5. Testar no Internal Track

# 6. Quando estável, promover para Beta
# Criar PR de 'internal' → 'beta'
# → Deploy automático para Beta Track! 🚀

# 7. Quando aprovado em Beta, promover para Produção
# Criar PR de 'beta' → 'main'
# → Deploy automático para Production! 🚀
```

## ⚠️ Importante Lembrar

- ❌ **NUNCA** commite keystore ou secrets
- ✅ **SEMPRE** teste localmente antes de criar PR
- ✅ Version code é incrementado automaticamente
- ✅ Production inicia com rollout de 10%
- ✅ Consulte a documentação quando tiver dúvidas

## 🎉 Pronto para Começar?

1. Abra [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)
2. Siga o guia passo a passo
3. Configure os secrets
4. Faça o primeiro deploy manual
5. A partir daí, é tudo automático! 🚀

---

**Boa sorte com o Santo Terço! 🙏📱**

**Dúvidas?** Consulte a documentação linkada acima.
