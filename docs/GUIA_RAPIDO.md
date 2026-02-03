# Guia Rápido - Entrega Contínua

## 📋 Pré-requisitos

Antes de usar o sistema de CD, certifique-se de:

✅ Ter configurado todos os secrets no GitHub (ver [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md))  
✅ Ter criado as branches `internal`, `beta` e `main`  
✅ Ter feito o primeiro upload manual para o Google Play  

## 🔄 Fluxo de Trabalho Diário

### 1. Nova Feature para Teste Interno

```bash
# Criar branch de feature
git checkout internal
git pull origin internal
git checkout -b feature/minha-feature

# Desenvolver...
git add .
git commit -m "feat: minha nova funcionalidade"
git push origin feature/minha-feature

# Criar PR para 'internal' no GitHub
# Após aprovação e merge → Deploy automático para Internal Track! 🚀
```

### 2. Promover para Beta

```bash
# Criar PR de internal → beta no GitHub
# Após aprovação e merge → Deploy automático para Beta Track! 🚀
```

### 3. Promover para Produção

```bash
# Criar PR de beta → main no GitHub
# Após aprovação e merge → Deploy automático para Production Track! 🚀
```

## 🎯 Comandos Úteis

### Ver Status dos Workflows
Acesse: `https://github.com/SEU_USUARIO/santo-terco/actions`

### Build Local
```bash
# Debug
flutter build appbundle --debug

# Release (requer keystore)
flutter build appbundle --release
```

### Testes
```bash
flutter test
```

### Atualizar Versão Manualmente
Edite `pubspec.yaml`:
```yaml
version: 1.1.0+42  # MAJOR.MINOR.PATCH+BUILD_NUMBER
```
O BUILD_NUMBER é incrementado automaticamente nos workflows.

## ⚠️ Importante

- **NÃO** commite arquivos sensíveis (`key.properties`, `*.jks`, `service-account.json`)
- **SEMPRE** teste localmente antes de criar PR
- Version code é incrementado automaticamente - não precisa alterar manualmente
- Para produção, o rollout inicial é 10% - aumente gradualmente no Play Console

## 🐛 Problemas Comuns

### Workflow não executa
- Verifique se o PR foi **mergeado** (não apenas fechado)
- Confirme que todos os secrets estão configurados

### Erro de version code
- O version code precisa ser maior que a última versão no Play Console
- Normalmente é incrementado automaticamente, mas pode ser ajustado manualmente no `pubspec.yaml`

### Erro de permissão
- Verifique se a service account tem as permissões corretas no Play Console

## 📚 Documentação Completa

- **Configuração Inicial**: [CONFIGURACAO_MANUAL.md](CONFIGURACAO_MANUAL.md)
- **Documentação Técnica**: [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs em GitHub Actions
2. Consulte a documentação completa
3. Verifique o Play Console para detalhes do erro

---

**Dica**: Marque este arquivo nos favoritos para referência rápida! ⭐
