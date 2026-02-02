# Santo Terço

Aplicativo de terço digital desenvolvido em Flutter.

## Descrição

Este aplicativo permite a recitação do terço de forma digital e interativa. O app é data-driven, utilizando arquivos JSON para configurar as contas e orações do terço.

## Estrutura do Projeto

### Modelos de Dados

- **Conta** (`lib/models/conta.dart`): Representa uma conta (bead) do terço
  - `tipo`: Tipo da conta (cruz, grande, pequena)
  - `oracoes`: Lista de orações associadas à conta
  - `ordem`: Ordem da conta no terço

- **Terço** (`lib/models/terco.dart`): Representa o terço completo
  - `nome`: Nome do terço
  - `descricao`: Descrição do terço
  - `contas`: Lista de contas do terço
  - `assets`: URLs dos assets (imagens, etc.)

### Serviços

- **TercoService** (`lib/services/terco_service.dart`): Serviço para carregar dados do terço a partir de arquivos JSON

### Telas

- **HomeScreen** (`lib/screens/home_screen.dart`): Tela principal do aplicativo
  - Exibe a conta atual
  - Mostra as orações da conta
  - Permite navegação entre as contas

### Widgets

- **ContaWidget** (`lib/widgets/conta_widget.dart`): Widget para exibir a conta atual
- **OracaoDisplay** (`lib/widgets/oracao_display.dart`): Widget para exibir as orações

### Configuração JSON

Os arquivos JSON de configuração ficam em `assets/data/`. Exemplo de estrutura:

```json
{
  "nome": "Terço Tradicional",
  "descricao": "Descrição do terço",
  "assets": {
    "cruz": "assets/images/cruz.png",
    "conta_grande": "assets/images/conta_grande.png",
    "conta_pequena": "assets/images/conta_pequena.png"
  },
  "contas": [
    {
      "ordem": 1,
      "tipo": "cruz",
      "oracoes": ["Oração 1", "Oração 2"]
    }
  ]
}
```

## Como Executar

1. Certifique-se de ter o Flutter instalado
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o aplicativo

## Funcionalidades Atuais

- ✅ Modelo de dados para contas e terço
- ✅ Carregamento de terço a partir de JSON
- ✅ Interface básica para exibição de contas e orações
- ✅ Navegação entre contas (anterior/próxima)
- ✅ Indicador de progresso

## Próximos Passos

- [ ] Implementar gestos de arrastar para navegar entre contas
- [ ] Adicionar visualização gráfica do terço com assets
- [ ] Implementar animações de transição entre contas
- [ ] Adicionar suporte a múltiplos terços
- [ ] Implementar histórico de recitações
