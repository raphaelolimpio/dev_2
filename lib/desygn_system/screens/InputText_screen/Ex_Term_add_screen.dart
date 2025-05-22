import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/input/input_text/input_text.dart';
import 'package:dev/desygn_system/components/input/input_text/input_text_view_model.dart';

class AddTermScreen extends StatefulWidget {
  const AddTermScreen({super.key});

  @override
  State<AddTermScreen> createState() => _AddTermScreenState();
}

class _AddTermScreenState extends State<AddTermScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _definicaoController = TextEditingController();
  final TextEditingController _comandoExemploController =
      TextEditingController();
  final TextEditingController _explicacaoPraticaController =
      TextEditingController();
  final TextEditingController _dicasDeUsoController = TextEditingController();

  // Para gerenciar os textos de erro de cada campo
  String? _nomeErrorText;
  String? _categoriaErrorText;
  String? _definicaoErrorText;

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _definicaoController.dispose();
    _comandoExemploController.dispose();
    _explicacaoPraticaController.dispose();
    _dicasDeUsoController.dispose();
    super.dispose();
  }

  // Exemplo de função de validação para um campo específico
  void _validateNome(String value) {
    setState(() {
      _nomeErrorText = value.isEmpty ? 'O nome do termo é obrigatório.' : null;
    });
  }

  void _validateDefinicao(String value) {
    setState(() {
      _definicaoErrorText = value.isEmpty ? 'A definição é obrigatória.' : null;
    });
  }

  void _validateCategoria(String value) {
    setState(() {
      _categoriaErrorText = value.isEmpty ? 'A categoria é obrigatória.' : null;
      // Você pode adicionar lógica para verificar se a categoria existe em uma lista pré-definida
    });
  }

  void _submitTerm() {
    // Forçar a validação de todos os campos importantes antes de enviar
    _validateNome(_nomeController.text);
    _validateCategoria(_categoriaController.text);
    _validateDefinicao(_definicaoController.text);

    if (_nomeErrorText == null &&
        _categoriaErrorText == null &&
        _definicaoErrorText == null) {
      // Se todos os campos obrigatórios estão válidos, crie o objeto JSON
      final newTerm = {
        "nome": _nomeController.text,
        "categoria": _categoriaController.text,
        "definicao": _definicaoController.text,
        "comando_exemplo":
            _comandoExemploController.text.isEmpty
                ? ""
                : _comandoExemploController.text,
        "explicacao_pratica":
            _explicacaoPraticaController.text.isEmpty
                ? ""
                : _explicacaoPraticaController.text,
        "dicas_de_uso":
            _dicasDeUsoController.text.isEmpty
                ? ""
                : _dicasDeUsoController.text,
      };
      print('Novo Termo JSON: $newTerm');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Termo adicionado com sucesso!')),
      );
      // Aqui você enviaria 'newTerm' para seu backend, banco de dados, etc.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha os campos obrigatórios.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Novo Termo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome do Termo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Ex: git init',
                controller: _nomeController,
                onChanged: _validateNome,
                errorText: _nomeErrorText,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Categoria',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Ex: Inicialização de repositório',
                controller: _categoriaController,
                onChanged: _validateCategoria,
                errorText: _categoriaErrorText,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Definição',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.large, // Definição pode ser maior
                hintText: 'Descreva o termo...',
                controller: _definicaoController,
                keyboardType:
                    TextInputType.multiline, // Habilita múltiplas linhas
                onChanged: _validateDefinicao,
                errorText: _definicaoErrorText,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Comando de Exemplo (Opcional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Ex: git init',
                controller: _comandoExemploController,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Explicação Prática (Opcional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.large,
                hintText: 'Detalhes de como usar na prática...',
                controller: _explicacaoPraticaController,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Dicas de Uso (Opcional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.large,
                hintText: 'Dicas e melhores práticas...',
                controller: _dicasDeUsoController,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _submitTerm,
                child: const Text('Adicionar Termo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
