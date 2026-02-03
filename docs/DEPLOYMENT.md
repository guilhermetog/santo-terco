# Documentação de Deployment - Santo Terço

## Visão Geral

Este projeto utiliza GitHub Actions e Fastlane para automatizar o processo de build e deploy para o Google Play Console. O sistema de entrega contínua está configurado com três ambientes:

- **Internal Track**: Para testes internos da equipe
- **Beta Track**: Para testes com um grupo maior de beta testers
- **Production Track**: Para todos os usuários do Google Play

## Arquitetura de Branches

```
main (production)
  ↑
  └── beta
       ↑
       └── internal
            ↑
            └── feature branches
```

### Branches Principais

1. **internal**: Branch para integração de features e testes internos
2. **beta**: Branch para testes beta com grupo expandido
3. **main**: Branch de produção

## Workflows

### Deploy para Internal Track
- **Trigger**: PR mergeado para a branch `internal`
- **Arquivo**: `.github/workflows/deploy-internal.yml`
- **Ações**:
  1. Executa testes
  2. Incrementa version code automaticamente
  3. Compila app bundle (.aab)
  4. Faz upload para Google Play Internal Track
  5. Commita o novo version code

### Deploy para Beta Track
- **Trigger**: PR mergeado para a branch `beta`
- **Arquivo**: `.github/workflows/deploy-beta.yml`
- **Ações**: Similares ao Internal, mas deploy para Beta Track

### Deploy para Production Track
- **Trigger**: PR mergeado para a branch `main`
- **Arquivo**: `.github/workflows/deploy-production.yml`
- **Ações**:
  1. Executa testes
  2. Incrementa version code
  3. Compila app bundle
  4. Faz upload para Google Play Production Track com rollout de 10%
  5. Cria GitHub Release com tag
  6. Commita o novo version code

## Gerenciamento de Versões

O sistema usa versionamento semântico com incremento automático:

```
version: MAJOR.MINOR.PATCH+BUILD_NUMBER
Exemplo: 1.0.0+42
```

- **MAJOR.MINOR.PATCH**: Controlado manualmente no `pubspec.yaml`
- **BUILD_NUMBER**: Incrementado automaticamente pelos workflows

### Como Atualizar a Versão Manualmente

Para uma nova versão maior/menor:

```bash
# Editar pubspec.yaml
version: 1.1.0+42  # Atualiza MAJOR.MINOR.PATCH conforme necessário
```

O BUILD_NUMBER será incrementado automaticamente no próximo deploy.

## Secrets Necessários

Os seguintes secrets devem estar configurados no GitHub:

| Secret | Descrição |
|--------|-----------|
| `KEYSTORE_BASE64` | Keystore Android em formato base64 |
| `KEYSTORE_PASSWORD` | Senha do keystore |
| `KEY_PASSWORD` | Senha da key dentro do keystore |
| `KEY_ALIAS` | Alias da key (geralmente "upload") |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | Credenciais da service account do Google Cloud |

## Estrutura de Arquivos

```
.github/
  workflows/
    deploy-internal.yml       # Workflow para internal track
    deploy-beta.yml          # Workflow para beta track
    deploy-production.yml    # Workflow para production track

android/
  fastlane/
    Fastfile                 # Configuração das lanes do Fastlane
    Appfile                  # Configuração do app
  Gemfile                    # Dependências Ruby
  key.properties            # Propriedades do keystore (gerado em CI, não commitado)
  app/
    upload-keystore.jks     # Keystore (gerado em CI, não commitado)
```

## Fluxo de Trabalho Recomendado

### Para uma Nova Feature

1. Criar branch a partir de `internal`:
   ```bash
   git checkout internal
   git pull origin internal
   git checkout -b feature/nova-funcionalidade
   ```

2. Desenvolver e testar localmente

3. Criar PR para `internal`:
   ```bash
   git push origin feature/nova-funcionalidade
   # Criar PR no GitHub para internal
   ```

4. Após aprovação e merge → Deploy automático para Internal Track

5. Testar no Internal Track

### Promover para Beta

1. Criar PR de `internal` para `beta`

2. Após aprovação e merge → Deploy automático para Beta Track

3. Testar com beta testers

### Promover para Production

1. Criar PR de `beta` para `main`

2. Após aprovação e merge → Deploy automático para Production Track

3. Monitorar rollout no Google Play Console

## Fastlane Lanes

### deploy_internal
Faz upload do app bundle para o track Internal do Google Play.

```bash
cd android
fastlane deploy_internal
```

### deploy_beta
Faz upload do app bundle para o track Beta do Google Play.

```bash
cd android
fastlane deploy_beta
```

### deploy_production
Faz upload do app bundle para o track Production do Google Play com rollout gradual.

```bash
cd android
fastlane deploy_production
```

## Build Local

Para compilar o app localmente:

```bash
# Debug build
flutter build appbundle --debug

# Release build (requer keystore configurado)
flutter build appbundle --release
```

## Testes

Execute os testes antes de criar um PR:

```bash
flutter test
```

Os workflows executam os testes automaticamente antes do deploy.

## Rollout Gradual

Para production, o deploy inicial usa rollout de 10%. Para aumentar:

1. Acesse o Google Play Console
2. Vá para **Production > Releases**
3. Clique na versão atual
4. Clique em **Increase rollout**
5. Escolha a porcentagem desejada (25%, 50%, 100%)

## Monitoramento

### GitHub Actions
- Acesse **Actions** no GitHub para ver o status dos workflows
- Logs detalhados disponíveis para cada step

### Google Play Console
- **Pre-launch reports**: Testes automáticos do Google
- **Android vitals**: Métricas de estabilidade e performance
- **User feedback**: Reviews e ratings

## Troubleshooting

### Workflow falha no build
1. Verifique os logs em Actions
2. Execute `flutter test` localmente
3. Verifique se há erros de compilação

### Workflow falha no upload
1. Verifique se todos os secrets estão configurados
2. Confirme permissões da service account no Play Console
3. Verifique se o version code é maior que a última versão publicada

### Version code conflict
Se o workflow falhar por version code duplicado:
1. Verifique a última versão no Play Console
2. Atualize manualmente no `pubspec.yaml` se necessário

## Segurança

⚠️ **IMPORTANTE**:

- **NUNCA** commite `key.properties` ou `upload-keystore.jks`
- **NUNCA** commite `service-account.json`
- **NUNCA** exponha os secrets do GitHub
- Mantenha o keystore em local seguro (backup em cofre de senhas)
- Use branch protection rules para evitar commits diretos

## Manutenção

### Atualizar Flutter
Quando atualizar a versão do Flutter, atualize também nos workflows:

```yaml
uses: subosito/flutter-action@v2
with:
  flutter-version: '3.24.0'  # Atualizar aqui
```

### Atualizar Fastlane
```bash
cd android
bundle update fastlane
```

## Referências

- [Flutter Deployment Guide](https://docs.flutter.dev/deployment/android)
- [Fastlane for Android](https://docs.fastlane.tools/getting-started/android/setup/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Google Play Publishing API](https://developers.google.com/android-publisher)

---

**Última atualização**: 2026-02-03
