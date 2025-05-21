// lib/desygn_system/screens/drawer_preview_screen.dart (CORRIGIDO)

import 'package:dev/desygn_system/components/appbar/appBar_custom.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/menu/custom_menu_button.dart';
import 'package:dev/desygn_system/components/menu/app_drawer_content.dart';
import 'package:dev/desygn_system/shared/color/colors.dart'; // Suas cores

class DrawerPreviewScreen extends StatefulWidget {
  const DrawerPreviewScreen({super.key});

  @override
  State<DrawerPreviewScreen> createState() => _DrawerPreviewScreenState();
}

class _DrawerPreviewScreenState extends State<DrawerPreviewScreen> {
  bool _isMenuOnRight = false; // Estado para controlar a posição do menu

  void _handleMenuItemSelected(String value, BuildContext context) {
    // ... (sua lógica de navegação já está correta aqui) ...
    switch (value) {
      case "profile":
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Navegando para Perfil!')));
        Navigator.pushNamed(context, "/profile");
        break;
      case "settings":
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Navegando para Configurações!')),
        );
        Navigator.pushNamed(context, "/settings");
        break;
      case "logout":
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Fazendo Logout!')));
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        break;
      default:
        debugPrint('Opção de menu desconhecida: $value');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // O Scaffold precisa estar presente no build.
    // O Builder é usado para obter um contexto que está abaixo do Scaffold.
    return Scaffold(
      drawer:
          _isMenuOnRight
              ? null
              : AppDrawerContent(onItemSelected: _handleMenuItemSelected),
      endDrawer:
          _isMenuOnRight
              ? AppDrawerContent(onItemSelected: _handleMenuItemSelected)
              : null,
      appBar: CustomAppBar(
        title: 'Menu Lateral Preview',
        backgroundColor: appNormalCyanColor,
        // *** AQUI ESTÁ A MUDANÇA: USAMOS Builder PARA OBTER O CONTEXTO CORRETO ***
        leading: Builder(
          builder: (BuildContext innerContext) {
            // innerContext é o contexto que tem o Scaffold
            return _isMenuOnRight
                ? const SizedBox.shrink() // Se o menu estiver à direita, não há leading button
                : CustomMenuButton(
                  icon: Icons.menu,
                  iconColor: kFontColorWhite,
                  onPressed:
                      () =>
                          Scaffold.of(
                            innerContext,
                          ).openDrawer(), // Usa innerContext
                );
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext innerContext) {
              // innerContext é o contexto que tem o Scaffold
              return _isMenuOnRight
                  ? CustomMenuButton(
                    icon: Icons.more_vert,
                    iconColor: kFontColorWhite,
                    onPressed:
                        () =>
                            Scaffold.of(
                              innerContext,
                            ).openEndDrawer(), // Usa innerContext
                  )
                  : const SizedBox.shrink(); // Se o menu estiver à esquerda, não há actions customizadas para o menu
            },
          ),
          // Se houver outras ações na AppBar que não são o botão do menu, elas iriam aqui.
          // Por exemplo, IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Arraste da borda para abrir o menu!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isMenuOnRight = !_isMenuOnRight;
                });
              },
              child: Text(
                _isMenuOnRight
                    ? 'Mover Menu para Esquerda'
                    : 'Mover Menu para Direita',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Menu está no lado: ${_isMenuOnRight ? 'Direito' : 'Esquerdo'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
