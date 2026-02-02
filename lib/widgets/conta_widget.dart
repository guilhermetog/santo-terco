import 'package:flutter/material.dart';
import '../models/conta.dart';

/// Widget para exibir uma conta do terço
class ContaWidget extends StatelessWidget {
  final Conta conta;
  final int numero;
  final int total;

  const ContaWidget({
    super.key,
    required this.conta,
    required this.numero,
    required this.total,
  });

  Color _getCorPorTipo(TipoConta tipo) {
    switch (tipo) {
      case TipoConta.cruz:
        return Colors.brown;
      case TipoConta.grande:
        return Colors.blue;
      case TipoConta.pequena:
        return Colors.grey;
    }
  }

  IconData _getIconePorTipo(TipoConta tipo) {
    switch (tipo) {
      case TipoConta.cruz:
        return Icons.add;
      case TipoConta.grande:
        return Icons.circle;
      case TipoConta.pequena:
        return Icons.circle_outlined;
    }
  }

  String _getNomeTipo(TipoConta tipo) {
    switch (tipo) {
      case TipoConta.cruz:
        return 'Cruz';
      case TipoConta.grande:
        return 'Conta Grande';
      case TipoConta.pequena:
        return 'Conta Pequena';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone da conta
            Icon(
              _getIconePorTipo(conta.tipo),
              size: 80,
              color: _getCorPorTipo(conta.tipo),
            ),
            const SizedBox(height: 16),
            
            // Tipo da conta
            Text(
              _getNomeTipo(conta.tipo),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            
            // Contador
            Text(
              'Conta $numero de $total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
