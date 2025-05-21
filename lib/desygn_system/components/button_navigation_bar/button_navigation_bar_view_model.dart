import 'package:flutter/material.dart';

enum BottomBarOptionSize { large, medium, small }

// Removida a enum IconStyle, pois o tamanho do ícone será inferido de BottomBarOptionSize

enum BottomNavigationBarStyle { primary, secondary, tertiary }

class BottomBarItem {
  final IconData icon;
  final String label;

  BottomBarItem({required this.icon, required this.label});
}

class BottomBarViewModel {
  final BottomBarOptionSize size;
  final BottomNavigationBarStyle style;
  final List<BottomBarItem> items;
  int
  selectedIndex; // Este campo será atualizado internamente pelo widget Stateful
  final Function(int) onItemSelected;

  BottomBarViewModel({
    required this.size,
    required this.style,
    required this.items,
    this.selectedIndex = 0, // Valor padrão para o item selecionado inicialmente
    required this.onItemSelected,
  });
}
