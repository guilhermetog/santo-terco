# Santo Terço

Aplicativo de terço digital desenvolvido em Flutter.

## Descrição

Este aplicativo permite a recitação do terço de forma digital e interativa. O app é data-driven, utilizando arquivos JSON para configurar as contas e orações do terço.

**Arquitetura Separada de Conteúdo e Layout:** O aplicativo separa o conteúdo (orações e sequência de contas) do layout visual (aparência e assets). Isso permite rezar o mesmo terço com diferentes visuais.

## Estrutura do Projeto

### Modelos de Dados

- **Conta** (`lib/models/conta.dart`): Representa uma conta (bead) do terço
  - `tipo`: Tipo da conta (cruz, grande, pequena)
  - `oracoes`: Lista de orações associadas à conta
  - `ordem`: Ordem da conta no terço

- **Terço** (`lib/models/terco.dart`): Representa o conteúdo do terço
  - `nome`: Nome do terço
  - `descricao`: Descrição do terço
  - `contas`: Lista de contas do terço

- **TercoLayout** (`lib/models/terco_layout.dart`): Representa a aparência visual do terço
  - `nome`: Nome do layout
  - `descricao`: Descrição do layout
  - `assets`: URLs dos assets visuais (imagens das contas, cruz, etc.)

### Serviços

- **TercoService** (`lib/services/terco_service.dart`): Serviço para carregar dados do terço
  - `carregarConteudo()`: Carrega o conteúdo do terço a partir de JSON
  - `carregarLayout()`: Carrega o layout visual a partir de JSON

### Telas

- **HomeScreen** (`lib/screens/home_screen.dart`): Tela principal do aplicativo
  - Carrega conteúdo e layout separadamente
  - Exibe a conta atual
  - Mostra as orações da conta
  - Permite navegação entre as contas
  - Mostra nome do layout no título

### Widgets

- **ContaWidget** (`lib/widgets/conta_widget.dart`): Widget para exibir a conta atual
- **OracaoDisplay** (`lib/widgets/oracao_display.dart`): Widget para exibir as orações

### Configuração JSON

Os arquivos JSON de configuração ficam em `assets/data/` e são separados em:

#### Arquivo de Conteúdo (ex: `terco_conteudo.json`)

```json
{
  "nome": "Terço Tradicional",
  "descricao": "Descrição do terço",
  "contas": [
    {
      "ordem": 1,
      "tipo": "cruz",
      "oracoes": ["Oração 1", "Oração 2"]
    }
  ]
}
```

#### Arquivo de Layout (ex: `layout_tradicional.json`)

```json
{
  "nome": "Layout Tradicional Madeira",
  "descricao": "Visual tradicional com contas de madeira",
  "assets": {
    "cruz": "assets/images/cruz.png",
    "conta_grande": "assets/images/conta_grande.png",
    "conta_pequena": "assets/images/conta_pequena.png"
  }
}
```

## Como Executar

1. Certifique-se de ter o Flutter instalado
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o aplicativo

## Funcionalidades Atuais

- ✅ Modelo de dados para contas e terço
- ✅ **Separação de conteúdo e layout visual**
- ✅ Carregamento de terço a partir de JSON
- ✅ Interface básica para exibição de contas e orações
- ✅ Navegação entre contas (anterior/próxima)
- ✅ Indicador de progresso
- ✅ Suporte a múltiplos layouts para o mesmo conteúdo

## Exemplos de Uso

### Mesmo Conteúdo, Layouts Diferentes

O aplicativo vem com exemplos de como usar o mesmo conteúdo com diferentes layouts:

- **Conteúdo:** `terco_conteudo.json` (orações tradicionais)
- **Layout 1:** `layout_tradicional.json` (visual com contas de madeira)
- **Layout 2:** `layout_moderno.json` (visual com contas de cristal)

Para mudar o layout, basta alterar o arquivo carregado em `HomeScreen`.

## Próximos Passos

- [ ] Implementar gestos de arrastar para navegar entre contas
- [ ] Adicionar visualização gráfica do terço com assets
- [ ] Implementar animações de transição entre contas
- [ ] Adicionar seletor de layout na interface
- [ ] Adicionar suporte a múltiplos conteúdos de terços
- [ ] Implementar histórico de recitações
