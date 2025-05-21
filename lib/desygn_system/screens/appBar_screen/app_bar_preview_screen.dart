import 'package:dev/desygn_system/components/appBar/appBar_custom.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/shared/color/colors.dart'; // Para testar diferentes cores

class AppBarPreviewScreen extends StatelessWidget {
  const AppBarPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Minha AppBar Personalizada',
        // Experimente mudar as cores aqui para ver como reage:
        backgroundColor: kCyan500, // Cor padrão que você definiu
        // backgroundColor: kRed500,
        // backgroundColor: kGray800,
        // leading: IconButton( // Exemplo de um leading customizado
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: [
          // Exemplo de uma ação extra (além do CustomMenu)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Botão de busca pressionado!')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Esta é a sua CustomAppBar em ação!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simula uma navegação para o perfil para testar o CustomMenu
                // (apenas para fins de demonstração, as rotas precisam estar configuradas)
                // Se suas rotas não estiverem configuradas, isso pode dar erro.
                // Aqui apenas mostraremos um SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tente o menu de 3 pontos no canto superior direito!',
                    ),
                  ),
                );
              },
              child: const Text('Testar Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
