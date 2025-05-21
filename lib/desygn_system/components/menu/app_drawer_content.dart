// lib/desygn_system/components/menu/app_drawer_content.dart
import 'package:dev/desygn_system/shared/color/colors.dart'; // Suas cores
import 'package:dev/desygn_system/shared/style/Style.dart'; // Seus estilos
import 'package:flutter/material.dart';

/// Define o conteúdo do menu lateral (Drawer/EndDrawer) do aplicativo.
class AppDrawerContent extends StatelessWidget {
  final Function(String value, BuildContext context) onItemSelected;

  const AppDrawerContent({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kGray200, // Cor de fundo do Drawer
      child: ListView(
        padding: EdgeInsets.zero, // Remove o padding padrão do ListView
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: appNormalCyanColor, // Cor do cabeçalho do Drawer
            ),
            child: Text(
              'Menu Principal',
              style: headingStyle.copyWith(
                color: kFontColorWhite,
              ), // Estilo do título do cabeçalho
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: kGray800),
            title: Text('Perfil', style: normalStyle.copyWith(color: kGray800)),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              onItemSelected("profile", context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: kGray800),
            title: Text(
              'Configurações',
              style: normalStyle.copyWith(color: kGray800),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              onItemSelected("settings", context);
            },
          ),
          const Divider(), // Linha divisória
          ListTile(
            leading: Icon(Icons.logout, color: kRed500),
            title: Text('Sair', style: normalStyle.copyWith(color: kRed500)),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              onItemSelected("logout", context);
            },
          ),
        ],
      ),
    );
  }
}
