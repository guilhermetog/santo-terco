import 'conta.dart';

/// Modelo do terço completo
class Terco {
  final String nome;
  final String descricao;
  final List<Conta> contas;
  final Map<String, String> assets;

  const Terco({
    required this.nome,
    required this.descricao,
    required this.contas,
    required this.assets,
  });

  factory Terco.fromJson(Map<String, dynamic> json) {
    return Terco(
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      contas: (json['contas'] as List<dynamic>?)
              ?.map((c) => Conta.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      assets: Map<String, String>.from(json['assets'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'contas': contas.map((c) => c.toJson()).toList(),
      'assets': assets,
    };
  }
}
