import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/terco.dart';

/// Serviço para carregar dados do terço
class TercoService {
  /// Carrega o modelo do terço a partir de um arquivo JSON
  Future<Terco> carregarTerco(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return Terco.fromJson(jsonData);
    } catch (e) {
      throw Exception('Erro ao carregar terço: $e');
    }
  }
}
