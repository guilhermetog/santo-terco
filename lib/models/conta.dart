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
    final tipoString = json['tipo'] as String?;
    final tipo = TipoConta.values.firstWhere(
      (e) => e.name == tipoString,
      orElse: () {
        // Log warning for invalid type
        if (tipoString != null) {
          print('Aviso: Tipo de conta inválido "$tipoString", usando "pequena" como padrão');
        }
        return TipoConta.pequena;
      },
    );
    
    return Conta(
      tipo: tipo,
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
