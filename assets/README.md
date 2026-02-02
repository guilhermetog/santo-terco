# Assets

Esta pasta contém os assets do aplicativo.

## Estrutura

- `images/`: Imagens do terço (contas, cruz, etc.)
- `data/`: Arquivos JSON com configurações do terço

## Separação de Conteúdo e Layout

O aplicativo usa uma arquitetura que separa o **conteúdo** (orações) do **layout** (aparência visual):

### Arquivos de Conteúdo

Contêm as orações e sequência de contas do terço:
- `terco_conteudo.json` - Terço tradicional com orações completas

### Arquivos de Layout

Contêm a configuração visual do terço:
- `layout_tradicional.json` - Visual tradicional com contas de madeira
- `layout_moderno.json` - Visual moderno com contas de cristal

### Vantagens

- Mesmo conteúdo pode ter diferentes aparências
- Fácil adicionar novos layouts sem duplicar orações
- Manutenção simplificada

## Imagens Necessárias

Para um funcionamento completo dos layouts, adicione as seguintes imagens em `images/`:

### Layout Tradicional
- `cruz.png`: Imagem da cruz tradicional
- `conta_grande.png`: Imagem de uma conta grande de madeira
- `conta_pequena.png`: Imagem de uma conta pequena de madeira
- `fundo.png`: Imagem de fundo (opcional)

### Layout Moderno
- `cruz_cristal.png`: Imagem da cruz de cristal
- `conta_grande_cristal.png`: Imagem de uma conta grande de cristal
- `conta_pequena_cristal.png`: Imagem de uma conta pequena de cristal
- `fundo_azul.png`: Imagem de fundo azul (opcional)

## Formato dos Arquivos JSON

### Arquivo de Conteúdo

```json
{
  "nome": "Nome do Terço",
  "descricao": "Descrição",
  "contas": [
    {
      "ordem": 1,
      "tipo": "cruz",
      "oracoes": ["Oração 1", "Oração 2"]
    }
  ]
}
```

### Arquivo de Layout

```json
{
  "nome": "Nome do Layout",
  "descricao": "Descrição do visual",
  "assets": {
    "cruz": "assets/images/cruz.png",
    "conta_grande": "assets/images/conta_grande.png",
    "conta_pequena": "assets/images/conta_pequena.png"
  }
}
```
