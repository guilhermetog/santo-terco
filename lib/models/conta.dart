/// Tipos de conta do terço
enum TipoConta {
  cruz,
  grande,
  pequena,
}

/// Modelo de uma conta (bead) do terço
class Conta {
  final TipoConta tipo;
  final List<String> oracoes;
  final int ordem;

  const Conta({
    required this.tipo,
    required this.oracoes,
    required this.ordem,
  });

  factory Conta.fromJson(Map<String, dynamic> json) {
    return Conta(
      tipo: TipoConta.values.firstWhere(
        (e) => e.name == json['tipo'],
        orElse: () => TipoConta.pequena,
      ),
      oracoes: List<String>.from(json['oracoes'] ?? []),
      ordem: json['ordem'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo.name,
      'oracoes': oracoes,
      'ordem': ordem,
    };
  }
}
