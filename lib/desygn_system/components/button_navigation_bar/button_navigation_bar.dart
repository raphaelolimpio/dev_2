import 'package:dev/desygn_system/components/button_navigation_bar/button_navigation_bar_view_model.dart';
import 'package:dev/desygn_system/shared/color/colors.dart'; // Importa suas cores
import 'package:dev/desygn_system/shared/style/Style.dart'; // Importa seus estilos
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  // Renomeado para CustomBottomNavigationBar para evitar conflito com o widget do Flutter
  final BottomBarViewModel viewModel;

  const CustomBottomNavigationBar._(this.viewModel);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState(); // Renomeado o State
  // para corresponder ao novo nome da classe
  static Widget instantiate({required BottomBarViewModel viewModel}) {
    return CustomBottomNavigationBar._(viewModel);
  }
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  // Renomeado o State
  late int _currentIndex; // Estado interno para o índice selecionado

  @override
  void initState() {
    super.initState();
    _currentIndex =
        widget.viewModel.selectedIndex; // Inicializa com o valor do ViewModel
  }

  // Método para obter o tamanho da fonte com base no BottomBarOptionSize
  double _getFontSize(BottomBarOptionSize size) {
    switch (size) {
      case BottomBarOptionSize.large:
        return 14; // Tamanho de fonte ajustado para large
      case BottomBarOptionSize.medium:
        return 12; // Tamanho de fonte ajustado para medium
      case BottomBarOptionSize.small:
        return 10; // Tamanho de fonte ajustado para small
    }
  }

  // Método para obter o tamanho do ícone com base no BottomBarOptionSize
  double _getIconSize(BottomBarOptionSize size) {
    switch (size) {
      case BottomBarOptionSize.large:
        return 28; // Tamanho de ícone ajustado para large
      case BottomBarOptionSize.medium:
        return 24; // Tamanho de ícone ajustado para medium
      case BottomBarOptionSize.small:
        return 20; // Tamanho de ícone ajustado para small
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definir cores e estilos com base no BottomNavigationBarStyle
    Color backgroundColor;
    Color selectedItemColor;
    Color unselectedItemColor;
    double itemHeight;

    switch (widget.viewModel.style) {
      case BottomNavigationBarStyle.primary:
        backgroundColor =
            appNormalCyanColor; // Exemplo: uma de suas cores ciano
        selectedItemColor = kFontColorWhite; // Texto/ícone branco para destaque
        unselectedItemColor =
            kCyanBlack; // Tom mais escuro de ciano para inativo
        break;
      case BottomNavigationBarStyle.secondary:
        backgroundColor = kGray800; // Fundo cinza escuro
        selectedItemColor = kYellowColor; // Destaque amarelo
        unselectedItemColor = kGray500; // Cinza médio para inativo
        break;
      case BottomNavigationBarStyle.tertiary:
        backgroundColor = kRed500; // Fundo vermelho
        selectedItemColor = kFontColorWhite; // Destaque branco
        unselectedItemColor =
            kRed200; // Tom mais claro de vermelho para inativo
        break;
    }

    // A altura do item será ajustada pelo padding interno, mas podemos ter um mínimo
    // para diferentes tamanhos
    switch (widget.viewModel.size) {
      case BottomBarOptionSize.large:
        itemHeight = 68.0; // Este parece estar OK, sem overflow reportado
        break;
      case BottomBarOptionSize.medium:
        itemHeight =
            62.0; // Aumentado de 60.0 para 62.0 para dar mais 2px de respiro
        break;
      case BottomBarOptionSize.small:
        itemHeight =
            56.0; // Aumentado de 54.0 para 56.0 para dar mais 2px de respiro
        break;
    }

    return Container(
      height: itemHeight,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.viewModel.items.length, (index) {
          final item = widget.viewModel.items[index];
          final bool isSelected = index == _currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  widget.viewModel.onItemSelected(index);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: _getIconSize(widget.viewModel.size),
                    color: isSelected ? selectedItemColor : unselectedItemColor,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: _getFontSize(widget.viewModel.size),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected ? selectedItemColor : unselectedItemColor,
                    ).copyWith(
                      // ... (seu copyWith existente) ...
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Removido BottomNavigationBarController - parece não estar em uso
