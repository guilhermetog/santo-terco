import 'package:flutter/material.dart';
import '../models/terco.dart';
import '../models/terco_layout.dart';
import '../models/conta.dart';
import '../services/terco_service.dart';
import '../widgets/conta_widget.dart';
import '../widgets/oracao_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TercoService _tercoService = TercoService();
  Terco? _terco;
  TercoLayout? _layout;
  int _contaAtual = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _carregarTerco();
  }

  Future<void> _carregarTerco() async {
    try {
      // Carrega conteúdo e layout separadamente
      final terco = await _tercoService.carregarConteudo('assets/data/terco_conteudo.json');
      final layout = await _tercoService.carregarLayout('assets/data/layout_tradicional.json');
      
      setState(() {
        _terco = terco;
        _layout = layout;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _proximaConta() {
    if (_terco != null && _contaAtual < _terco!.contas.length - 1) {
      setState(() {
        _contaAtual++;
      });
    }
  }

  void _contaAnterior() {
    if (_contaAtual > 0) {
      setState(() {
        _contaAtual--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Erro ao carregar terço',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Verifique se os arquivos de dados existem e estão no formato correto.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_terco == null || _terco!.contas.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Nenhum terço carregado'),
        ),
      );
    }

    final contaAtual = _terco!.contas[_contaAtual];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_terco!.nome),
            if (_layout != null)
              Text(
                _layout!.nome,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Indicador de progresso
          LinearProgressIndicator(
            value: (_contaAtual + 1) / _terco!.contas.length,
          ),
          const SizedBox(height: 16),
          
          // Visualização da conta atual
          Expanded(
            flex: 2,
            child: ContaWidget(
              conta: contaAtual,
              numero: _contaAtual + 1,
              total: _terco!.contas.length,
            ),
          ),
          
          // Exibição das orações
          Expanded(
            flex: 3,
            child: OracaoDisplay(
              oracoes: contaAtual.oracoes,
            ),
          ),
          
          // Controles de navegação
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _contaAtual > 0 ? _contaAnterior : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Anterior'),
                ),
                ElevatedButton.icon(
                  onPressed: _contaAtual < _terco!.contas.length - 1
                      ? _proximaConta
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Próxima'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
