import 'package:dev/desygn_system/components/appBar/appBar_custom.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/button_navigation_bar/button_navigation_bar_view_model.dart';
import 'package:dev/desygn_system/components/button_navigation_bar/button_navigation_bar.dart'; // Importa sua CustomBottomNavigationBar

class BottomNavBarPreviewScreen extends StatefulWidget {
  const BottomNavBarPreviewScreen({super.key});

  @override
  State<BottomNavBarPreviewScreen> createState() =>
      _BottomNavBarPreviewScreenState();
}

class _BottomNavBarPreviewScreenState extends State<BottomNavBarPreviewScreen> {
  int _selectedIndex1 = 0;
  int _selectedIndex2 = 0;
  int _selectedIndex3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview da Bottom Navigation Bar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Exemplo 1: Large - Primary Style ---
            const Text(
              'Estilo Grande (Large) - Primário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              // Contém o Scaffold para a BottomNavigationBar
              height: 100, // Altura para exibir a barra isoladamente
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Scaffold(
                body: Center(
                  child: Text('Conteúdo selecionado: ${_selectedIndex1}'),
                ),
                bottomNavigationBar: CustomBottomNavigationBar.instantiate(
                  viewModel: BottomBarViewModel(
                    size: BottomBarOptionSize.large,
                    style: BottomNavigationBarStyle.primary,
                    items: [
                      BottomBarItem(icon: Icons.home, label: 'Início'),
                      BottomBarItem(icon: Icons.search, label: 'Buscar'),
                      BottomBarItem(
                        icon: Icons.notifications,
                        label: 'Alertas',
                      ),
                      BottomBarItem(icon: Icons.person, label: 'Perfil'),
                    ],
                    selectedIndex: _selectedIndex1,
                    onItemSelected: (index) {
                      setState(() {
                        _selectedIndex1 = index;
                      });
                      _showSnackBar(
                        context,
                        'Item Large selecionado: ${index}',
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Exemplo 2: Medium - Secondary Style ---
            const Text(
              'Estilo Médio (Medium) - Secundário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              height: 90, // Altura para exibir a barra isoladamente
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Scaffold(
                body: Center(
                  child: Text('Conteúdo selecionado: ${_selectedIndex2}'),
                ),
                bottomNavigationBar: CustomBottomNavigationBar.instantiate(
                  viewModel: BottomBarViewModel(
                    size: BottomBarOptionSize.medium,
                    style: BottomNavigationBarStyle.secondary,
                    items: [
                      BottomBarItem(icon: Icons.dashboard, label: 'Dashboard'),
                      BottomBarItem(icon: Icons.settings, label: 'Config'),
                      BottomBarItem(icon: Icons.info, label: 'Sobre'),
                    ],
                    selectedIndex: _selectedIndex2,
                    onItemSelected: (index) {
                      setState(() {
                        _selectedIndex2 = index;
                      });
                      _showSnackBar(
                        context,
                        'Item Medium selecionado: ${index}',
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Exemplo 3: Small - Tertiary Style ---
            const Text(
              'Estilo Pequeno (Small) - Terciário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              height: 80, // Altura para exibir a barra isoladamente
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Scaffold(
                body: Center(
                  child: Text('Conteúdo selecionado: ${_selectedIndex3}'),
                ),
                bottomNavigationBar: CustomBottomNavigationBar.instantiate(
                  viewModel: BottomBarViewModel(
                    size: BottomBarOptionSize.small,
                    style: BottomNavigationBarStyle.tertiary,
                    items: [
                      BottomBarItem(icon: Icons.email, label: 'Email'),
                      BottomBarItem(icon: Icons.chat, label: 'Chat'),
                    ],
                    selectedIndex: _selectedIndex3,
                    onItemSelected: (index) {
                      setState(() {
                        _selectedIndex3 = index;
                      });
                      _showSnackBar(
                        context,
                        'Item Small selecionado: ${index}',
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
