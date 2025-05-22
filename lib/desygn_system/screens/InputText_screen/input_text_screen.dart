// lib/your_project_name/screens/input_text_screen.dart

import 'package:dev/desygn_system/components/input/input_text/input_text.dart'; // Seu InputText
import 'package:dev/desygn_system/components/input/input_text/input_text_view_model.dart'; // Seu InputTextViewModel
import 'package:dev/desygn_system/shared/color/colors.dart';
import 'package:flutter/material.dart';

class InputTextScreen extends StatefulWidget {
  const InputTextScreen({super.key});

  @override
  State<InputTextScreen> createState() => _InputTextScreenState();
}

class _InputTextScreenState extends State<InputTextScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _disabledController = TextEditingController(
    text: 'Campo desabilitado',
  );

  String? _nameErrorText;
  String? _phoneErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  bool _obscurePassword = true; // Para alternar a visibilidade da senha

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _disabledController.dispose();
    super.dispose();
  }

  // Simula uma validação em tempo real (chamado no onChanged)
  void _validateField(String value, InputTextType type) {
    setState(() {
      switch (type) {
        case InputTextType.phone:
          final String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
          _phoneErrorText =
              (cleanedValue.length < 10 || cleanedValue.length > 11) &&
                      cleanedValue.isNotEmpty
                  ? 'Telefone inválido (10 ou 11 dígitos)'
                  : null;
          break;
        case InputTextType.email:
          _emailErrorText =
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value) &&
                      value.isNotEmpty
                  ? 'E-mail inválido'
                  : null;
          break;
        case InputTextType.password:
          _passwordErrorText =
              value.length < 6 && value.isNotEmpty
                  ? 'A senha deve ter pelo menos 6 caracteres'
                  : null;
          break;
        default:
          _nameErrorText =
              value.isEmpty
                  ? 'Nome não pode ser vazio'
                  : null; // Exemplo simples
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplos de InputText')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Input Text - Tamanho Pequeno (Small)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.small,
                hintText: 'Seu nome',
                controller: _nameController,
                keyboardType: TextInputType.name,
                onChanged:
                    (value) => _validateField(value, InputTextType.string),
                errorText: _nameErrorText,
                prefixIcon: const Icon(
                  Icons.person_outline,
                ), // Ícone personalizado
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Input Text - Tamanho Médio (Medium) - Telefone',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Seu telefone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputType:
                    InputTextType.phone, // Usar para formatação e validação
                onChanged:
                    (value) => _validateField(value, InputTextType.phone),
                errorText: _phoneErrorText,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Input Text - Tamanho Grande (Large) - E-mail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.large,
                hintText: 'Seu e-mail',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                inputType: InputTextType.email,
                onChanged:
                    (value) => _validateField(value, InputTextType.email),
                errorText: _emailErrorText,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Input Text - Senha com Toggle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Sua senha',
                controller: _passwordController,
                obscureText: _obscurePassword, // Controlado pelo estado
                keyboardType: TextInputType.visiblePassword,
                inputType: InputTextType.password,
                onChanged:
                    (value) => _validateField(value, InputTextType.password),
                errorText: _passwordErrorText,
                suffixIcon: IconButton(
                  // Botão para alternar visibilidade
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: kGray600,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Input Text - Desabilitado',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InputText(
              viewModel: InputTextViewModel(
                size: InputTextSize.medium,
                hintText: 'Este campo está desabilitado',
                controller: _disabledController,
                isEnabled: false, // Campo desabilitado
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Você pode fazer uma validação final aqui ou usar um Form widget
                  final bool isValid =
                      _nameErrorText == null &&
                      _phoneErrorText == null &&
                      _emailErrorText == null &&
                      _passwordErrorText == null;

                  if (isValid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Dados válidos! Nome: ${_nameController.text}, Tel: ${_phoneController.text}',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Por favor, corrija os erros nos campos.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Validar Campos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
