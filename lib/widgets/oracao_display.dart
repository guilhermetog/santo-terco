import 'package:flutter/material.dart';

/// Widget para exibir as orações da conta atual
class OracaoDisplay extends StatelessWidget {
  final List<String> oracoes;

  const OracaoDisplay({
    super.key,
    required this.oracoes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oração${oracoes.length > 1 ? 'ões' : ''}:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...oracoes.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.5,
                      ),
                  textAlign: TextAlign.justify,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
