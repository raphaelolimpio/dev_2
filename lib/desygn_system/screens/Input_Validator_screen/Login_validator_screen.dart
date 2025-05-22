import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/input/input_text_validator/input_text_validator.dart';
import 'package:dev/desygn_system/components/input/input_text_validator/input_text_validator_view_model.dart';
import 'package:dev/desygn_system/shared/color/colors.dart'; // Para usar as cores

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Chave para o Form

  // Funções de validação para passar para o InputTextValidator
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void _performLogin() {
    if (_formKey.currentState!.validate()) {
      // Se o formulário é válido, proceed com o login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tentando login com: Email: ${_emailController.text}, Senha: ${_passwordController.text}',
          ),
        ),
      );
      // Aqui você faria a chamada para sua API de autenticação
    } else {
      // O formulário já mostrou os erros de validação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros do formulário.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          // Use o Form para validação
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Bem-vindo de volta!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Campo de E-mail
              InputTextValidator(
                viewModel: InputTextValidatorViewModel(
                  size: InputTextSize.medium,
                  hintText: 'Seu e-mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validator: _validateEmail, // Passa a função de validação
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              InputTextValidator(
                viewModel: InputTextValidatorViewModel(
                  size: InputTextSize.medium,
                  hintText: 'Sua senha',
                  controller: _passwordController,
                  obscureText: true, // Começa oculto
                  keyboardType: TextInputType.visiblePassword,
                  validator: _validatePassword, // Passa a função de validação
                  prefixIcon: const Icon(Icons.lock_outline),
                  // suffixIcon será o toggle de visibilidade gerado internamente
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _performLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appNormalCyanColor, // Sua cor primária
                  foregroundColor: kFontColorWhite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  // Ação para "Esqueceu a senha?"
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Implementar "Esqueceu a senha?"'),
                    ),
                  );
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: appNormalCyanColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
