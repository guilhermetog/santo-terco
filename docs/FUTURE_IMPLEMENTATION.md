# Plano de Implementação Futura

Este documento descreve as próximas funcionalidades a serem implementadas no aplicativo Santo Terço.

## Funcionalidades Planejadas

### 1. Gestos de Arrastar (Drag Gestures)

Implementar `GestureDetector` ou `Draggable`/`DragTarget` para permitir que o usuário arraste o terço para navegar entre as contas.

```dart
GestureDetector(
  onHorizontalDragEnd: (details) {
    if (details.primaryVelocity! < 0) {
      // Arrastar para a esquerda - próxima conta
      _proximaConta();
    } else if (details.primaryVelocity! > 0) {
      // Arrastar para a direita - conta anterior
      _contaAnterior();
    }
  },
  child: // Widget do terço
)
```

### 2. Visualização Gráfica do Terço

Criar um widget customizado que desenha o terço usando os assets:
- Usar `CustomPaint` para desenhar as contas
- Posicionar imagens de assets nas posições corretas
- Destacar a conta atual
- Permitir toques/cliques nas contas para navegação direta

### 3. Animações de Transição

Adicionar animações suaves entre as contas:
- `PageView` com animações de página
- `AnimatedSwitcher` para transições de orações
- `Hero` animations para ícones de contas

### 4. Múltiplos Terços

Suporte a diferentes tipos de terço:
- Terço tradicional (59 contas)
- Terço da Misericórdia
- Outros terços especiais

Implementar uma tela de seleção de terço:

```dart
class TercoSelectionScreen extends StatelessWidget {
  final List<String> tercosDisponiveis = [
    'assets/data/terco_tradicional.json',
    'assets/data/terco_misericordia.json',
  ];
  // ...
}
```

### 5. Histórico de Recitações

Armazenar informações sobre recitações completadas:
- Usar `shared_preferences` ou `sqflite`
- Salvar data/hora de cada terço rezado
- Exibir estatísticas (terços por dia/semana/mês)

```dart
class RecitacaoHistorico {
  final DateTime data;
  final String tercoNome;
  final bool completado;
  
  // Salvar/carregar do storage local
}
```

### 6. Modo de Áudio

Opcional: Adicionar áudio das orações:
- Usar `audioplayers` package
- Reproduzir oração automaticamente ao mudar de conta
- Botão para ativar/desativar áudio

### 7. Personalização

Permitir ao usuário personalizar:
- Tema (cores, modo escuro)
- Tamanho da fonte
- Velocidade de transição entre contas
- Assets personalizados

### 8. Modo de Meditação

Adicionar tempo de meditação entre mistérios:
- Timer configurável
- Som/vibração ao final da meditação

## Estrutura de Código Sugerida

```
lib/
  models/
    conta.dart
    terco.dart
    recitacao_historico.dart (novo)
  services/
    terco_service.dart
    audio_service.dart (novo)
    storage_service.dart (novo)
  screens/
    home_screen.dart
    terco_selection_screen.dart (novo)
    historico_screen.dart (novo)
    configuracoes_screen.dart (novo)
  widgets/
    conta_widget.dart
    oracao_display.dart
    terco_visual_widget.dart (novo)
    progresso_widget.dart (novo)
```

## Dependências Sugeridas

Adicionar ao `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  shared_preferences: ^2.2.0  # Para salvar configurações e histórico
  audioplayers: ^5.0.0        # Para reprodução de áudio (opcional)
  sqflite: ^2.3.0             # Para banco de dados local (opcional)
  provider: ^6.0.5            # Para gerenciamento de estado
```

## Prioridades de Implementação

1. **Alta Prioridade**
   - Gestos de arrastar
   - Visualização gráfica do terço
   - Animações de transição

2. **Média Prioridade**
   - Múltiplos terços
   - Histórico de recitações
   - Personalização básica

3. **Baixa Prioridade**
   - Modo de áudio
   - Modo de meditação avançado
   - Compartilhamento social
