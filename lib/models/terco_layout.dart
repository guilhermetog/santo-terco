import 'package:flutter/foundation.dart';

/// Modelo de layout visual do terço
class TercoLayout {
  static const String _defaultNome = 'Layout sem nome';
  
  final String nome;
  final String descricao;
  final Map<String, String> assets;

  const TercoLayout({
    required this.nome,
    required this.descricao,
    required this.assets,
  });

  factory TercoLayout.fromJson(Map<String, dynamic> json) {
    final nome = json['nome'] as String?;
    final descricao = json['descricao'] as String?;
    final assetsData = json['assets'];
    
    if (nome == null || nome.isEmpty) {
      debugPrint('Aviso: Layout sem nome, usando valor padrão');
    }
    
    if (assetsData == null || assetsData is! Map) {
      debugPrint('Aviso: Layout sem assets válidos, usando mapa vazio');
    }
    
    return TercoLayout(
      nome: nome ?? _defaultNome,
      descricao: descricao ?? '',
      assets: assetsData is Map ? Map<String, String>.from(assetsData) : {},
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
