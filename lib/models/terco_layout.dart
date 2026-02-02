/// Modelo de layout visual do terço
class TercoLayout {
  final String nome;
  final String descricao;
  final Map<String, String> assets;

  const TercoLayout({
    required this.nome,
    required this.descricao,
    required this.assets,
  });

  factory TercoLayout.fromJson(Map<String, dynamic> json) {
    return TercoLayout(
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      assets: Map<String, String>.from(json['assets'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'assets': assets,
    };
  }
}
