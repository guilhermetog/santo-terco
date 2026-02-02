# Santo Terço - Resumo do Projeto

## O que foi criado

Este projeto estabelece a estrutura básica para um aplicativo Flutter de terço digital com **separação de conteúdo e layout visual**.

## Arquivos Criados

### Configuração do Projeto
- `pubspec.yaml` - Configuração do projeto Flutter com dependências
- `.gitignore` - Ignora arquivos de build e dependências

### Modelos de Dados (`lib/models/`)
- `conta.dart` - Modelo para cada conta do terço
- `terco.dart` - Modelo para o **conteúdo** do terço (orações, sequência)
- `terco_layout.dart` - Modelo para o **layout visual** do terço (assets, aparência)

### Serviços (`lib/services/`)
- `terco_service.dart` - Carrega conteúdo e layout de arquivos JSON separados

### Interface (`lib/screens/` e `lib/widgets/`)
- `main.dart` - Ponto de entrada do aplicativo
- `home_screen.dart` - Tela principal com navegação de contas (carrega conteúdo + layout)
- `conta_widget.dart` - Widget para exibir a conta atual
- `oracao_display.dart` - Widget para exibir as orações

### Assets

#### Arquivos de Conteúdo
- `assets/data/terco_conteudo.json` - Conteúdo do terço (orações e sequência de contas)

#### Arquivos de Layout
- `assets/data/layout_tradicional.json` - Layout visual tradicional (madeira)
- `assets/data/layout_moderno.json` - Layout visual moderno (cristal)
- `assets/images/` - Diretório para imagens (vazio)

#### Arquivo Antigo (mantido para referência)
- `assets/data/terco_exemplo.json` - Exemplo antigo com conteúdo e layout misturados

### Documentação (`docs/`)
- `ARCHITECTURE.md` - Documentação da arquitetura (atualizada)
- `FUTURE_IMPLEMENTATION.md` - Plano de funcionalidades futuras
- `SUMMARY.md` - Este arquivo

## Como Funciona

### Separação de Conteúdo e Layout

**Antes:**
- Um único arquivo JSON continha orações + assets
- Para ter visuais diferentes, precisava duplicar todas as orações

**Agora:**
- Arquivo de **conteúdo** (`terco_conteudo.json`): orações e sequência de contas
- Arquivo de **layout** (`layout_*.json`): aparência visual e assets
- Mesmo conteúdo pode ser usado com diferentes layouts

### Fluxo de Uso

1. O aplicativo carrega um arquivo de conteúdo
2. O aplicativo carrega um arquivo de layout
3. O conteúdo define QUAIS orações rezar e em qual ordem
4. O layout define COMO o terço deve aparecer visualmente
5. A interface combina ambos para a experiência completa

## Estrutura dos Dados

### Conteúdo do Terço
- Nome e descrição do terço
- Lista de contas (cruz, grande, pequena)
- Cada conta tem uma ou mais orações
- **Sem referências a assets visuais**

### Layout do Terço
- Nome e descrição do layout
- URLs para assets visuais (cruz, contas, fundo)
- **Sem referências a orações**

## Exemplos de Uso

### Mesmo Conteúdo, Layouts Diferentes

```dart
// Carrega o conteúdo uma vez
final conteudo = await service.carregarConteudo('terco_conteudo.json');

// Pode usar com layout tradicional
final layoutTrad = await service.carregarLayout('layout_tradicional.json');

// Ou com layout moderno
final layoutMod = await service.carregarLayout('layout_moderno.json');

// As orações são as mesmas, apenas a aparência muda!
```

## Próximas Funcionalidades

- Gestos de arrastar para navegar
- Visualização gráfica do terço usando os assets do layout
- Animações de transição
- **Seletor de layout na interface** (trocar entre tradicional/moderno)
- Múltiplos conteúdos de terço
- Histórico de recitações

## Como Testar

1. Instale o Flutter SDK
2. Execute `flutter pub get`
3. Execute `flutter run` em um dispositivo/emulador

## Tecnologias Utilizadas

- Flutter SDK 3.0+
- Dart
- Material Design 3

## Vantagens da Arquitetura Atual

1. **Reutilização**: Mesmo conteúdo com diferentes visuais
2. **Manutenção**: Orações e assets gerenciados separadamente
3. **Flexibilidade**: Fácil adicionar novos layouts sem tocar no conteúdo
4. **Escalabilidade**: Suporte a múltiplos conteúdos e layouts
