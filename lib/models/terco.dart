import 'conta.dart';

/// Modelo do conteúdo do terço (orações e sequência de contas)
class Terco {
  final String nome;
  final String descricao;
  final List<Conta> contas;

  const Terco({
    required this.nome,
    required this.descricao,
    required this.contas,
  });

  factory Terco.fromJson(Map<String, dynamic> json) {
    return Terco(
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      contas: (json['contas'] as List<dynamic>?)
              ?.map((c) => Conta.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'contas': contas.map((c) => c.toJson()).toList(),
    };
  }
}
