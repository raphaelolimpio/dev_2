// lib/main.dart (APENAS PARA VISUALIZAÇÃO TEMPORÁRIA)
import 'package:dev/desygn_system/screens/Custom_card/custom_cards_preview_screen.dart';
import 'package:dev/desygn_system/screens/InputText_screen/input_text_screen.dart';
import 'package:dev/desygn_system/screens/Input_Validator_screen/Login_validator_screen.dart';
import 'package:dev/desygn_system/screens/List_card/List_card_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes UI Preview',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          const LoginScreen(), // Chame a tela de visualização dos Custom Cards
      // Mantenha suas rotas se for usá-las em outras partes do app.
      routes: {
        // Exemplo de rotas que você pode ter definido:
        // '/profile': (context) => const DummyScreen(title: 'Perfil'),
        // '/settings': (context) => const DummyScreen(title: 'Configurações'),
        // '/login': (context) => const DummyScreen(title: 'Login'),
      },
    );
  }
}

// Sua classe DummyScreen, se você a tiver definido
/*
class DummyScreen extends StatelessWidget {
  final String title;
  const DummyScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Você está na tela de $title!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
*/
