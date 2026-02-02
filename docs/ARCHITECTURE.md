# Arquitetura do Aplicativo Santo Terço

## Visão Geral

O aplicativo Santo Terço é um aplicativo Flutter data-driven para recitação do terço católico. A arquitetura foi projetada para ser simples, extensível e fácil de manter.

**Separação de Conteúdo e Layout:** Uma das principais características é a separação completa entre o conteúdo (orações, sequência de contas) e o layout visual (aparência, assets). Isso permite que o mesmo conteúdo seja rezado com diferentes representações visuais.

## Princípios de Design

1. **Data-Driven**: Toda a configuração do terço vem de arquivos JSON
2. **Separação de Responsabilidades**: Modelos, serviços e UI são separados
3. **Conteúdo vs Layout**: Conteúdo e aparência visual são independentes
4. **Simplicidade**: Código limpo e fácil de entender
5. **Extensibilidade**: Fácil adicionar novos tipos de terço ou layouts

## Estrutura de Diretórios

```
santo_terco/
├── lib/
│   ├── main.dart                 # Ponto de entrada do app
│   ├── models/                   # Modelos de dados
│   │   ├── conta.dart            # Modelo de conta individual
│   │   ├── terco.dart            # Modelo do conteúdo do terço
│   │   └── terco_layout.dart     # Modelo do layout visual
│   ├── services/                 # Lógica de negócio
│   │   └── terco_service.dart    # Carregamento de dados JSON
│   ├── screens/                  # Telas do aplicativo
│   │   └── home_screen.dart      # Tela principal
│   └── widgets/                  # Widgets reutilizáveis
│       ├── conta_widget.dart     # Visualização de conta
│       └── oracao_display.dart   # Visualização de orações
├── assets/
│   ├── data/                     # Arquivos JSON de configuração
│   │   ├── terco_conteudo.json   # Conteúdo do terço
│   │   ├── layout_tradicional.json # Layout tradicional
│   │   └── layout_moderno.json   # Layout moderno
│   └── images/                   # Imagens e assets visuais
└── docs/                         # Documentação
    ├── ARCHITECTURE.md           # Este arquivo
    └── FUTURE_IMPLEMENTATION.md  # Plano de funcionalidades futuras
```

## Camada de Modelos

### Conta (`lib/models/conta.dart`)

Representa uma conta individual do terço.

**Propriedades:**
- `tipo`: Enum que define o tipo (cruz, grande, pequena)
- `oracoes`: Lista de strings com as orações dessa conta
- `ordem`: Ordem sequencial da conta no terço

**Métodos:**
- `fromJson()`: Factory constructor para criar a partir de JSON
- `toJson()`: Serializar para JSON

### Terço (`lib/models/terco.dart`)

Representa o **conteúdo** do terço (sem informações visuais).

**Propriedades:**
- `nome`: Nome do terço
- `descricao`: Descrição do terço
- `contas`: Lista de objetos Conta

**Métodos:**
- `fromJson()`: Factory constructor para criar a partir de JSON
- `toJson()`: Serializar para JSON

### TercoLayout (`lib/models/terco_layout.dart`)

Representa a **aparência visual** do terço.

**Propriedades:**
- `nome`: Nome do layout
- `descricao`: Descrição do layout
- `assets`: Mapa com URLs dos assets visuais

**Métodos:**
- `fromJson()`: Factory constructor para criar a partir de JSON
- `toJson()`: Serializar para JSON

## Camada de Serviços

### TercoService (`lib/services/terco_service.dart`)

Responsável por carregar e parsear os dados do terço.

**Métodos:**
- `carregarConteudo(String assetPath)`: Carrega o conteúdo do terço
- `carregarLayout(String assetPath)`: Carrega o layout visual do terço

**Responsabilidades:**
- Ler arquivos JSON dos assets
- Parsear JSON para objetos tipados
- Tratamento de erros de carregamento

## Camada de UI

### HomeScreen (`lib/screens/home_screen.dart`)

Tela principal do aplicativo.

**Estado:**
- `_terco`: Objeto Terco com o conteúdo
- `_layout`: Objeto TercoLayout com a aparência
- `_contaAtual`: Índice da conta atual
- `_isLoading`: Flag de carregamento
- `_errorMessage`: Mensagem de erro (se houver)

**Funcionalidades:**
- Carrega terço e layout na inicialização
- Exibe indicador de progresso
- Permite navegação entre contas
- Exibe conta atual e suas orações
- Mostra nome do layout no título

### ContaWidget (`lib/widgets/conta_widget.dart`)

Widget para exibir a conta atual.

**Propriedades:**
- `conta`: Objeto Conta a exibir
- `numero`: Número da conta atual
- `total`: Total de contas no terço

**Funcionalidades:**
- Exibe ícone apropriado para o tipo de conta
- Mostra cores diferentes por tipo
- Exibe contador de progresso

### OracaoDisplay (`lib/widgets/oracao_display.dart`)

Widget para exibir as orações da conta atual.

**Propriedades:**
- `oracoes`: Lista de orações a exibir

**Funcionalidades:**
- Exibe múltiplas orações com scroll
- Formatação legível das orações

## Formato de Dados JSON

### Arquivo de Conteúdo

```json
{
  "nome": "Terço Tradicional",
  "descricao": "Terço católico tradicional",
  "contas": [
    {
      "ordem": 1,
      "tipo": "cruz",
      "oracoes": [
        "Texto da oração 1",
        "Texto da oração 2"
      ]
    }
  ]
}
```

### Arquivo de Layout

```json
{
  "nome": "Layout Tradicional",
  "descricao": "Visual com contas de madeira",
  "assets": {
    "cruz": "caminho/para/cruz.png",
    "conta_grande": "caminho/para/conta_grande.png",
    "conta_pequena": "caminho/para/conta_pequena.png"
  }
}
```

### Tipos de Conta Suportados

- `"cruz"`: Cruz do terço
- `"grande"`: Conta grande (Pai Nosso)
- `"pequena"`: Conta pequena (Ave Maria)

## Fluxo de Dados

```
1. Aplicativo inicia
2. HomeScreen carrega no initState()
3. TercoService.carregarConteudo() é chamado
4. JSON de conteúdo é lido dos assets
5. TercoService.carregarLayout() é chamado
6. JSON de layout é lido dos assets
7. Objetos são parseados (Terco e TercoLayout)
8. Estado é atualizado com terço e layout carregados
9. UI renderiza com os dados
10. Usuário navega entre contas
11. Estado _contaAtual é atualizado
12. UI re-renderiza com nova conta
```

## Separação de Conteúdo e Layout

### Vantagens

1. **Flexibilidade Visual**: Mesmo conteúdo pode ter diferentes aparências
2. **Reutilização**: Um layout pode ser usado com diferentes conteúdos
3. **Manutenção**: Orações e assets são gerenciados separadamente
4. **Personalização**: Fácil adicionar novos layouts sem alterar conteúdo

### Exemplo de Uso

```dart
// Carrega mesmo conteúdo com diferentes layouts
final conteudo = await service.carregarConteudo('terco_conteudo.json');
final layout1 = await service.carregarLayout('layout_tradicional.json');
final layout2 = await service.carregarLayout('layout_moderno.json');

// Pode alternar entre layouts mantendo o mesmo conteúdo
```

## Gerenciamento de Estado

Atualmente usando **setState** simples:
- Adequado para o escopo atual do aplicativo
- Fácil de entender e manter
- Pode ser migrado para Provider, Riverpod ou Bloc no futuro

## Tratamento de Erros

- Erros de carregamento são capturados em try-catch
- Mensagens de erro são exibidas ao usuário
- Estado de carregamento é gerenciado com flag booleana
- Erros incluem contexto (qual arquivo falhou)

## Considerações de Performance

- JSONs são carregados apenas uma vez na inicialização
- Widgets são reconstruídos apenas quando necessário
- Dados são mantidos em memória (tamanho fixo ~60 contas)
- Carregamento paralelo de conteúdo e layout

## Extensibilidade

### Adicionar Novo Tipo de Conta

1. Adicionar novo valor ao enum `TipoConta`
2. Atualizar métodos de cor/ícone em `ContaWidget`
3. Criar contas com o novo tipo no JSON de conteúdo

### Adicionar Novo Layout

1. Criar novo arquivo JSON em `assets/data/`
2. Seguir a estrutura do arquivo de layout
3. Referenciar novos assets de imagem
4. Trocar a referência em `HomeScreen.carregarLayout()`

### Adicionar Novo Conteúdo de Terço

1. Criar novo arquivo JSON de conteúdo
2. Seguir a estrutura do arquivo exemplo
3. Pode usar qualquer layout existente

### Adicionar Nova Funcionalidade

1. Criar novos serviços em `lib/services/`
2. Criar novas telas em `lib/screens/`
3. Criar novos widgets em `lib/widgets/`
4. Atualizar modelos se necessário

## Dependências

**Produção:**
- `flutter`: SDK do Flutter
- `cupertino_icons`: Ícones iOS-style

**Desenvolvimento:**
- `flutter_test`: Framework de testes
- `flutter_lints`: Regras de lint

## Testes

Estrutura de testes a ser implementada:
- Unit tests para modelos (fromJson/toJson)
- Unit tests para serviços
- Widget tests para widgets
- Integration tests para fluxos completos

## Próximos Passos Arquiteturais

1. Implementar gerenciamento de estado mais robusto (Provider)
2. Adicionar camada de repository para abstrair acesso aos dados
3. Implementar cache de conteúdos e layouts carregados
4. Adicionar testes automatizados
5. Implementar seletor de layout na UI
6. Implementar internacionalização (i18n)
