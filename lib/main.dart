// lib/main.dart (APENAS PARA VISUALIZAÇÃO TEMPORÁRIA)
import 'package:dev/desygn_system/screens/card_screen/cards_preview_screen.dart';
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
          const CardsPreviewScreen(), // Chame a tela de visualização dos Cards
      // Mantenha suas rotas se for usá-las em outras partes do app,
      // mas para este preview, só a home é importante.
      routes: {
        // '/profile': (context) => const DummyScreen(title: 'Perfil'),
        // ...
      },
    );
  }
}

// Uma tela dummy, se necessário para simular navegações (como no CustomAppBar)
// Se você já tem essa classe, pode ignorar esta parte.
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
