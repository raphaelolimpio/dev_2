// lib/desygn_system/components/menu/custom_menu_button.dart
import 'package:flutter/material.dart';

/// Um botão customizado para abrir um menu lateral (Drawer/EndDrawer).
/// A lógica de qual Drawer abrir e qual ícone usar é definida pelo pai.
class CustomMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? iconColor; // Permite customizar a cor do ícone

  const CustomMenuButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.menu, // Ícone padrão de menu (hambúrguer)
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(icon, color: iconColor), onPressed: onPressed);
  }
}
