import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/terco.dart';
import '../models/terco_layout.dart';

/// Serviço para carregar dados do terço
class TercoService {
  /// Carrega o conteúdo do terço a partir de um arquivo JSON
  Future<Terco> carregarConteudo(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return Terco.fromJson(jsonData);
    } catch (e, stackTrace) {
      throw Exception('Erro ao carregar conteúdo do terço de $assetPath: $e\n$stackTrace');
    }
  }

  /// Carrega o layout visual do terço a partir de um arquivo JSON
  Future<TercoLayout> carregarLayout(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return TercoLayout.fromJson(jsonData);
    } catch (e, stackTrace) {
      throw Exception('Erro ao carregar layout do terço de $assetPath: $e\n$stackTrace');
    }
  }

  /// Carrega o modelo do terço a partir de um arquivo JSON (mantido para compatibilidade)
  @Deprecated('Use carregarConteudo() e carregarLayout() separadamente')
  Future<Terco> carregarTerco(String assetPath) async {
    return carregarConteudo(assetPath);
  }
}
