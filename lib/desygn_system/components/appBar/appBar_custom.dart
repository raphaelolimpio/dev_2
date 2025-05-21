import 'package:dev/desygn_system/shared/color/colors.dart'; // Suas cores
import 'package:dev/desygn_system/shared/style/Style.dart'; // Seus estilos
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Widget? leading; // O botão do menu virá por aqui, ou será null
  final List<Widget>? actions; // Outras ações (além do menu) virão por aqui
  final double elevation;
  final Color? iconColor; // Cor dos ícones na AppBar

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = kCyan500, // Usando uma das cores da sua paleta
    this.leading,
    this.actions, // Agora `actions` pode incluir o CustomMenuButton OU outros botões
    this.elevation = 4.0, // Elevação padrão
    this.iconColor, // Pode ser null para usar a cor padrão do AppBar Theme
  });

  // O método _onMenuItemSelected e a lógica do PopUpMenuButton são REMOVIDOS daqui
  // Eles pertencem à tela que gerencia o Drawer/EndDrawer.

  @override
  Widget build(BuildContext context) {
    final Color effectiveIconColor =
        iconColor ??
        (backgroundColor.computeLuminance() > 0.5
            ? kFontColorBlack
            : kFontColorWhite);

    return AppBar(
      title: Text(
        title,
        style: headingStyle.copyWith(color: effectiveIconColor),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      iconTheme: IconThemeData(color: effectiveIconColor),
      actionsIconTheme: IconThemeData(color: effectiveIconColor),
      toolbarTextStyle: TextStyle(color: effectiveIconColor),

      leading: leading, // O `CustomMenuButton` pode ser passado aqui
      actions:
          actions, // O `CustomMenuButton` ou outros botões podem ser passados aqui
      // A lógica do menu lateral não vive mais diretamente na AppBar,
      // mas é "injetada" pela tela pai através de `leading` ou `actions`.
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
