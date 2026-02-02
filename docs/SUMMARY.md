# Santo Terço - Resumo do Projeto

## O que foi criado

Este projeto estabelece a estrutura básica para um aplicativo Flutter de terço digital.

## Arquivos Criados

### Configuração do Projeto
- `pubspec.yaml` - Configuração do projeto Flutter com dependências
- `.gitignore` - Ignora arquivos de build e dependências

### Modelos de Dados (`lib/models/`)
- `conta.dart` - Modelo para cada conta do terço
- `terco.dart` - Modelo para o terço completo

### Serviços (`lib/services/`)
- `terco_service.dart` - Carrega dados JSON e cria objetos Terço

### Interface (`lib/screens/` e `lib/widgets/`)
- `main.dart` - Ponto de entrada do aplicativo
- `home_screen.dart` - Tela principal com navegação de contas
- `conta_widget.dart` - Widget para exibir a conta atual
- `oracao_display.dart` - Widget para exibir as orações

### Assets
- `assets/data/terco_exemplo.json` - Exemplo de configuração de terço
- `assets/images/` - Diretório para imagens (vazio)

### Documentação (`docs/`)
- `ARCHITECTURE.md` - Documentação da arquitetura
- `FUTURE_IMPLEMENTATION.md` - Plano de funcionalidades futuras

## Como Funciona

1. O aplicativo carrega um arquivo JSON com a configuração do terço
2. O JSON define todas as contas, seus tipos e orações
3. A interface exibe a conta atual e suas orações
4. O usuário pode navegar entre as contas usando botões
5. Um indicador de progresso mostra o avanço no terço

## Estrutura dos Dados

Cada terço tem:
- Nome e descrição
- Lista de contas (cruz, grande, pequena)
- Cada conta tem uma ou mais orações
- URLs para assets visuais

## Próximas Funcionalidades

- Gestos de arrastar para navegar
- Visualização gráfica do terço
- Animações de transição
- Múltiplos tipos de terço
- Histórico de recitações

## Como Testar

1. Instale o Flutter SDK
2. Execute `flutter pub get`
3. Execute `flutter run` em um dispositivo/emulador

## Tecnologias Utilizadas

- Flutter SDK 3.0+
- Dart
- Material Design 3
