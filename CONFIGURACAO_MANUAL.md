# Configuração Manual - Entrega Contínua Google Play

Este documento descreve todos os passos que você precisa configurar manualmente no GitHub e no Google Play Console para habilitar a entrega contínua do aplicativo Santo Terço.

## Índice
1. [Configuração do Google Play Console](#1-configuração-do-google-play-console)
2. [Configuração do GitHub](#2-configuração-do-github)
3. [Criação das Branches](#3-criação-das-branches)
4. [Primeiro Deploy Manual](#4-primeiro-deploy-manual)
5. [Fluxo de Trabalho](#5-fluxo-de-trabalho)

---

## 1. Configuração do Google Play Console

### 1.1. Criar uma Conta de Serviço no Google Cloud

1. Acesse o [Google Cloud Console](https://console.cloud.google.com/)
2. Selecione ou crie um projeto vinculado ao seu app
3. Vá para **IAM & Admin > Service Accounts**
4. Clique em **Create Service Account**
5. Preencha:
   - **Name**: `github-actions-deployer`
   - **Description**: `Service account for GitHub Actions to deploy to Google Play`
6. Clique em **Create and Continue**
7. Adicione a role **Service Account User**
8. Clique em **Done**
9. Na lista de service accounts, clique nos três pontos da conta criada e selecione **Manage Keys**
10. Clique em **Add Key > Create New Key**
11. Selecione **JSON** e clique em **Create**
12. **Salve o arquivo JSON baixado em local seguro** (você precisará dele para configurar o GitHub)

### 1.2. Vincular a Service Account ao Google Play Console

1. Acesse o [Google Play Console](https://play.google.com/console/)
2. Selecione seu app (ou crie um novo se ainda não existe)
3. Vá para **Setup > API access**
4. Na seção **Service accounts**, clique em **Link existing service account**
5. Clique no link para o **Google Cloud Console**
6. Copie o email da service account criada no passo 1.1
7. Volte ao Play Console e cole o email
8. Clique em **Apply**
9. Na tabela de service accounts, clique em **Grant Access** para a conta criada
10. Configure as permissões:
    - **Account permissions**: Marque **Admin (all permissions)**
    - Ou, para maior segurança, marque apenas:
      - **View app information and download bulk reports**
      - **Create and edit draft apps**
      - **Release to testing tracks**
      - **Release to production**
11. Clique em **Invite user**

### 1.3. Criar e Configurar Upload Keystore

O keystore é necessário para assinar o app. Você precisa criar um se ainda não tiver:

```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload \
  -storetype JKS
```

Durante a criação, você será solicitado a fornecer:
- **Keystore password**: Crie uma senha forte e anote
- **Key password**: Pode ser a mesma senha do keystore ou diferente, anote
- **Informações do certificado**: Nome, organização, cidade, etc.

**IMPORTANTE**: 
- Guarde o arquivo `upload-keystore.jks` em local seguro
- Anote as senhas (keystore password e key password)
- **NUNCA** commite este arquivo no Git

### 1.4. Configurar Tracks no Google Play

1. No Google Play Console, vá para **Testing > Internal testing**
2. Clique em **Create new release** para configurar o track interno
3. Faça o mesmo para **Testing > Closed testing** (para beta)
4. Configure testers para cada track conforme necessário

---

## 2. Configuração do GitHub

### 2.1. Adicionar Secrets ao Repositório

Vá para o seu repositório no GitHub: **Settings > Secrets and variables > Actions**

Clique em **New repository secret** e adicione os seguintes secrets:

#### Secret 1: KEYSTORE_BASE64
1. No seu terminal, converta o keystore para base64:
   ```bash
   base64 -i upload-keystore.jks | tr -d '\n' > keystore_base64.txt
   ```
2. Copie o conteúdo do arquivo `keystore_base64.txt`
3. No GitHub, cole este valor no secret **KEYSTORE_BASE64**

#### Secret 2: KEYSTORE_PASSWORD
- Valor: A senha do keystore que você criou no passo 1.3

#### Secret 3: KEY_PASSWORD
- Valor: A senha da key que você criou no passo 1.3

#### Secret 4: KEY_ALIAS
- Valor: `upload` (ou o alias que você usou ao criar o keystore)

#### Secret 5: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
1. Abra o arquivo JSON da service account que você baixou no passo 1.1
2. Copie todo o conteúdo do arquivo
3. Cole no secret **GOOGLE_PLAY_SERVICE_ACCOUNT_JSON**

### 2.2. Verificar Secrets Configurados

Após adicionar todos os secrets, você deve ter:
- ✅ `KEYSTORE_BASE64`
- ✅ `KEYSTORE_PASSWORD`
- ✅ `KEY_PASSWORD`
- ✅ `KEY_ALIAS`
- ✅ `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`

---

## 3. Criação das Branches

Execute os seguintes comandos no seu repositório local:

```bash
# Certifique-se de estar na branch main
git checkout main
git pull origin main

# Criar branch internal
git checkout -b internal
git push -u origin internal

# Criar branch beta
git checkout main
git checkout -b beta
git push -u origin beta

# Voltar para main
git checkout main
```

### 3.1. Configurar Branch Protection Rules (Recomendado)

Para cada branch (internal, beta, main):

1. Vá para **Settings > Branches**
2. Clique em **Add branch protection rule**
3. Configure para cada branch:
   - **Branch name pattern**: `internal` (ou `beta`, `main`)
   - Marque:
     - ✅ **Require a pull request before merging**
     - ✅ **Require approvals** (pelo menos 1)
     - ✅ **Require status checks to pass before merging**
   - Clique em **Create**

---

## 4. Primeiro Deploy Manual

Antes de usar o CI/CD, você precisa fazer um primeiro upload manual do app para cada track:

### 4.1. Gerar o App Bundle

```bash
# No diretório raiz do projeto
flutter build appbundle --release
```

### 4.2. Upload Manual para Internal Track

1. Vá para **Google Play Console > Testing > Internal testing**
2. Clique em **Create new release**
3. Faça upload do arquivo `build/app/outputs/bundle/release/app-release.aab`
4. Adicione as release notes
5. Clique em **Review release** e depois em **Start rollout to Internal testing**

### 4.3. Configurar Testers

1. No track Internal, clique em **Testers**
2. Crie uma lista de emails de testers ou compartilhe o link de opt-in
3. Os testers receberão acesso ao app através do Google Play

---

## 5. Fluxo de Trabalho

### 5.1. Deploy para Internal Track

Quando você quiser fazer deploy para teste interno:

1. Crie uma branch de feature a partir de `internal`:
   ```bash
   git checkout internal
   git pull origin internal
   git checkout -b feature/minha-feature
   ```

2. Faça suas alterações e commits

3. Crie um Pull Request para a branch `internal`

4. Após aprovação e merge do PR:
   - O GitHub Actions será acionado automaticamente
   - O app será compilado
   - O version code será incrementado automaticamente
   - O app será enviado para o track Internal do Google Play
   - A versão no `pubspec.yaml` será atualizada automaticamente

5. Os testers internos receberão a atualização automaticamente pelo Google Play

### 5.2. Promover para Beta Track

Quando uma versão internal estiver estável:

1. Crie um Pull Request de `internal` para `beta`

2. Após aprovação e merge:
   - O GitHub Actions enviará para o track Beta
   - Mais testers terão acesso

### 5.3. Promover para Production Track

Quando uma versão beta estiver aprovada:

1. Crie um Pull Request de `beta` para `main`

2. Após aprovação e merge:
   - O GitHub Actions enviará para produção com rollout de 10%
   - Um GitHub Release será criado automaticamente
   - Você pode aumentar o rollout gradualmente no Play Console

---

## 6. Troubleshooting

### Erro: "The APK/AAB needs to have a higher version code"

O version code no `pubspec.yaml` precisa ser maior que a última versão no Google Play. O workflow incrementa automaticamente, mas se houver problemas:

1. Verifique a versão no Play Console
2. Atualize manualmente no `pubspec.yaml`: `version: 1.0.0+X` (onde X > versão atual)

### Erro: "The service account does not have permissions"

Verifique se a service account tem as permissões corretas no Play Console (passo 1.2).

### Erro: "Invalid keystore format"

Certifique-se de que o arquivo keystore foi corretamente convertido para base64 e que não há quebras de linha no secret.

### Workflow não é executado após merge do PR

1. Verifique se o PR foi mergeado (não apenas fechado)
2. Confirme que o workflow existe na branch de destino
3. Verifique os logs em **Actions** no GitHub

---

## 7. Manutenção

### Atualizar a Service Account Key

Se você precisar rotacionar a chave:

1. Crie uma nova key no Google Cloud Console (passo 1.1)
2. Atualize o secret `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` no GitHub
3. Revogue a chave antiga no Google Cloud Console

### Renovar Keystore

⚠️ **NUNCA** renove ou troque o keystore de upload após o primeiro deploy em produção. Isso impossibilitará atualizações do app.

Se você perdeu o keystore, siga as [instruções do Google](https://support.google.com/googleplay/android-developer/answer/7384423) para recuperação.

---

## 8. Recursos Adicionais

- [Documentação oficial do Fastlane Supply](https://docs.fastlane.tools/actions/supply/)
- [GitHub Actions com Flutter](https://docs.flutter.dev/deployment/cd#github-actions)
- [Google Play Publishing API](https://developers.google.com/android-publisher)

---

## Checklist de Configuração

Use este checklist para garantir que tudo está configurado:

- [ ] Service account criada no Google Cloud
- [ ] Service account vinculada ao Google Play Console com permissões corretas
- [ ] Upload keystore criado e salvo em local seguro
- [ ] Todos os 5 secrets adicionados ao GitHub
- [ ] Branches `internal`, `beta` e `main` criadas
- [ ] Branch protection rules configuradas (opcional mas recomendado)
- [ ] Primeiro upload manual feito para o track Internal
- [ ] Testers configurados no Play Console
- [ ] Workflow testado com um PR de teste

---

**Última atualização**: 2026-02-03
