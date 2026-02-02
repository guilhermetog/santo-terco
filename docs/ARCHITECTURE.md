# Arquitetura do Aplicativo Santo Terço

## Visão Geral

O aplicativo Santo Terço é um aplicativo Flutter data-driven para recitação do terço católico. A arquitetura foi projetada para ser simples, extensível e fácil de manter.

## Princípios de Design

1. **Data-Driven**: Toda a configuração do terço vem de arquivos JSON
2. **Separação de Responsabilidades**: Modelos, serviços e UI são separados
3. **Simplicidade**: Código limpo e fácil de entender
4. **Extensibilidade**: Fácil adicionar novos tipos de terço ou funcionalidades

## Estrutura de Diretórios

```
santo_terco/
├── lib/
│   ├── main.dart                 # Ponto de entrada do app
│   ├── models/                   # Modelos de dados
│   │   ├── conta.dart            # Modelo de conta individual
│   │   └── terco.dart            # Modelo do terço completo
│   ├── services/                 # Lógica de negócio
│   │   └── terco_service.dart    # Carregamento de dados JSON
│   ├── screens/                  # Telas do aplicativo
│   │   └── home_screen.dart      # Tela principal
│   └── widgets/                  # Widgets reutilizáveis
│       ├── conta_widget.dart     # Visualização de conta
│       └── oracao_display.dart   # Visualização de orações
├── assets/
│   ├── data/                     # Arquivos JSON de configuração
│   │   └── terco_exemplo.json    # Exemplo de terço
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

Representa o terço completo.

**Propriedades:**
- `nome`: Nome do terço
- `descricao`: Descrição do terço
- `contas`: Lista de objetos Conta
- `assets`: Mapa com URLs dos assets visuais

**Métodos:**
- `fromJson()`: Factory constructor para criar a partir de JSON
- `toJson()`: Serializar para JSON

## Camada de Serviços

### TercoService (`lib/services/terco_service.dart`)

Responsável por carregar e parsear os dados do terço.

**Métodos:**
- `carregarTerco(String assetPath)`: Carrega um terço a partir de um arquivo JSON

**Responsabilidades:**
- Ler arquivo JSON dos assets
- Parsear JSON para objeto Terço
- Tratamento de erros de carregamento

## Camada de UI

### HomeScreen (`lib/screens/home_screen.dart`)

Tela principal do aplicativo.

**Estado:**
- `_terco`: Objeto Terço carregado
- `_contaAtual`: Índice da conta atual
- `_isLoading`: Flag de carregamento
- `_errorMessage`: Mensagem de erro (se houver)

**Funcionalidades:**
- Carrega o terço na inicialização
- Exibe indicador de progresso
- Permite navegação entre contas
- Exibe conta atual e suas orações

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

### Estrutura do Arquivo JSON

```json
{
  "nome": "Nome do Terço",
  "descricao": "Descrição do terço",
  "assets": {
    "cruz": "caminho/para/cruz.png",
    "conta_grande": "caminho/para/conta_grande.png",
    "conta_pequena": "caminho/para/conta_pequena.png"
  },
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

### Tipos de Conta Suportados

- `"cruz"`: Cruz do terço
- `"grande"`: Conta grande (Pai Nosso)
- `"pequena"`: Conta pequena (Ave Maria)

## Fluxo de Dados

```
1. Aplicativo inicia
2. HomeScreen carrega no initState()
3. TercoService.carregarTerco() é chamado
4. JSON é lido dos assets
5. JSON é parseado para objeto Terço
6. Estado é atualizado com o terço carregado
7. UI renderiza com os dados
8. Usuário navega entre contas
9. Estado _contaAtual é atualizado
10. UI re-renderiza com nova conta
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

## Considerações de Performance

- JSON é carregado apenas uma vez na inicialização
- Widgets são reconstruídos apenas quando necessário
- Lista de contas é mantida em memória (tamanho fixo ~60 contas)

## Extensibilidade

### Adicionar Novo Tipo de Conta

1. Adicionar novo valor ao enum `TipoConta`
2. Atualizar métodos de cor/ícone em `ContaWidget`
3. Criar contas com o novo tipo no JSON

### Adicionar Novo Terço

1. Criar novo arquivo JSON em `assets/data/`
2. Seguir a estrutura do arquivo exemplo
3. Adicionar referência no `pubspec.yaml` se necessário

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
3. Implementar cache de terços carregados
4. Adicionar testes automatizados
5. Implementar internacionalização (i18n)
