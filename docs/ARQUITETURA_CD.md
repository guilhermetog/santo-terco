# Arquitetura de Entrega Contínua - Santo Terço

## Visão Geral do Sistema

```
┌─────────────────────────────────────────────────────────────────┐
│                    DESENVOLVIMENTO                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ git push
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GITHUB REPOSITORY                             │
│                                                                  │
│  ┌────────────┐    ┌────────────┐    ┌────────────┐           │
│  │  feature/  │───▶│  internal  │───▶│    beta    │───▶main   │
│  │  branch    │ PR │   branch   │ PR │   branch   │ PR │ branch│
│  └────────────┘    └────────────┘    └────────────┘    └───────┘
└─────────────────────────────────────────────────────────────────┘
                         │                 │                │
                         │ PR Merge        │ PR Merge       │ PR Merge
                         ▼                 ▼                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GITHUB ACTIONS                                │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Deploy     │  │   Deploy     │  │   Deploy     │          │
│  │   Internal   │  │     Beta     │  │  Production  │          │
│  │   Workflow   │  │   Workflow   │  │   Workflow   │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│         │                 │                  │                  │
│         │ Build + Test    │ Build + Test     │ Build + Test    │
│         │ Version++       │ Version++        │ Version++       │
│         ▼                 ▼                  ▼                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  app.aab     │  │  app.aab     │  │  app.aab     │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                         │                 │                │
                         │ Fastlane        │ Fastlane       │ Fastlane
                         ▼                 ▼                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE PLAY CONSOLE                           │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Internal   │  │     Beta     │  │  Production  │          │
│  │    Track     │  │    Track     │  │    Track     │          │
│  │              │  │              │  │ (10% rollout)│          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│         │                 │                  │                  │
└─────────────────────────────────────────────────────────────────┘
          │                 │                  │
          │                 │                  │
          ▼                 ▼                  ▼
    ┌─────────┐       ┌─────────┐       ┌─────────┐
    │ Testers │       │  Beta   │       │  Todos  │
    │ Internos│       │ Testers │       │Usuários │
    └─────────┘       └─────────┘       └─────────┘
```

## Fluxo Detalhado de Deploy

### 1. Desenvolvimento → Internal Track

```
Developer               GitHub                 CI/CD              Google Play
    │                     │                      │                     │
    │  Create feature     │                      │                     │
    │  branch            │                      │                     │
    │─────────────────────▶                      │                     │
    │                     │                      │                     │
    │  Develop & commit   │                      │                     │
    │─────────────────────▶                      │                     │
    │                     │                      │                     │
    │  Create PR to       │                      │                     │
    │  internal          │                      │                     │
    │─────────────────────▶                      │                     │
    │                     │                      │                     │
    │                     │  Trigger CI Tests    │                     │
    │                     │─────────────────────▶│                     │
    │                     │                      │                     │
    │                     │  Tests pass ✓        │                     │
    │                     │◀─────────────────────│                     │
    │                     │                      │                     │
    │  Review & Approve   │                      │                     │
    │─────────────────────▶                      │                     │
    │                     │                      │                     │
    │  Merge PR          │                      │                     │
    │─────────────────────▶                      │                     │
    │                     │                      │                     │
    │                     │  Trigger Deploy      │                     │
    │                     │  Workflow           │                     │
    │                     │─────────────────────▶│                     │
    │                     │                      │                     │
    │                     │                      │  Build & Test       │
    │                     │                      │  Version++          │
    │                     │                      │  Create .aab        │
    │                     │                      │                     │
    │                     │                      │  Deploy to          │
    │                     │                      │  Internal Track     │
    │                     │                      │────────────────────▶│
    │                     │                      │                     │
    │                     │                      │  Success ✓          │
    │                     │                      │◀────────────────────│
    │                     │                      │                     │
    │                     │  Commit version bump │                     │
    │                     │◀─────────────────────│                     │
    │                     │                      │                     │
    │  Notification ✓     │                      │                     │
    │◀─────────────────────                      │                     │
```

### 2. Promoção entre Tracks

```
Internal Track → Beta Track → Production Track
      │               │               │
      │ PR            │ PR            │ PR
      │ merge         │ merge         │ merge
      ▼               ▼               ▼
   Deploy           Deploy          Deploy
   Auto             Auto            Auto
```

## Componentes do Sistema

### GitHub Actions Workflows

1. **ci-tests.yml**: Executa em todo PR
   - Formatação do código
   - Análise estática
   - Testes unitários
   - Build de debug

2. **deploy-internal.yml**: Executa quando PR é mergeado em `internal`
   - Build de release
   - Incremento de versão
   - Deploy para Internal Track

3. **deploy-beta.yml**: Executa quando PR é mergeado em `beta`
   - Build de release
   - Incremento de versão
   - Deploy para Beta Track

4. **deploy-production.yml**: Executa quando PR é mergeado em `main`
   - Build de release
   - Incremento de versão
   - Deploy para Production Track (10% rollout)
   - Criação de GitHub Release

### Fastlane

Lanes configuradas:
- `deploy_internal`: Upload para track interno
- `deploy_beta`: Upload para track beta
- `deploy_production`: Upload para produção com rollout

### Secrets Gerenciados

```
GitHub Secrets (Encrypted)
    │
    ├─▶ KEYSTORE_BASE64
    ├─▶ KEYSTORE_PASSWORD
    ├─▶ KEY_PASSWORD
    ├─▶ KEY_ALIAS
    └─▶ GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
```

## Versionamento Automático

```
pubspec.yaml: version: 1.0.0+42
                        │      │  │
                        │      │  └─▶ BUILD_NUMBER (auto incremento)
                        │      └────▶ PATCH
                        └───────────▶ MAJOR.MINOR
```

Cada deploy incrementa automaticamente o BUILD_NUMBER:
- Deploy 1: `1.0.0+1`
- Deploy 2: `1.0.0+2`
- Deploy 3: `1.0.0+3`
- etc.

## Estratégia de Rollout

### Internal Track
- **Público**: Equipe interna
- **Rollout**: 100% imediato
- **Objetivo**: Validação rápida de features

### Beta Track
- **Público**: Beta testers
- **Rollout**: 100% imediato
- **Objetivo**: Testes com usuários reais

### Production Track
- **Público**: Todos os usuários
- **Rollout**: Inicial 10%, depois gradual
- **Objetivo**: Minimizar impacto de bugs

## Segurança

### Camadas de Proteção

1. **Branch Protection Rules**
   - Require PR reviews
   - Require status checks
   - No direct commits

2. **Encrypted Secrets**
   - GitHub Secrets
   - Nunca commitados no código

3. **Keystore Seguro**
   - Armazenado em base64 no GitHub
   - Temporário durante CI
   - Removido após deploy

4. **Service Account**
   - Permissões mínimas necessárias
   - Acesso auditável

## Monitoramento

### Durante Deploy
- Logs em tempo real no GitHub Actions
- Notificações de sucesso/falha

### Pós-Deploy
- Google Play Console → Pre-launch reports
- Android vitals
- Crash reports
- User reviews

---

**Este diagrama deve ser mantido atualizado conforme o sistema evolui.**
