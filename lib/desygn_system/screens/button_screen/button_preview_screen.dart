import 'package:dev/desygn_system/components/appBar/appBar_custom.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/button/button.dart';
import 'package:dev/desygn_system/components/button/button_view_model.dart';

class ButtonPreviewScreen extends StatelessWidget {
  const ButtonPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview de Botões'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Botões Pequenos (Small) ---
              const Text(
                'Botões Pequenos (Small)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.small,
                  style: ButtonStyleColor.redColor,
                  textStyle: ButtonTextStyle.buttonStyle1, // Texto branco
                  title: 'Ação Pequena 1',
                  onPressed:
                      () => _showSnackBar(context, 'Pequeno 1 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.small,
                  style: ButtonStyleColor.greenColor,
                  textStyle: ButtonTextStyle.buttonStyle2, // Texto preto
                  title: 'Pequeno c/ Ícone',
                  icon: Icons.check_circle_outline,
                  onPressed:
                      () => _showSnackBar(context, 'Pequeno 2 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.small,
                  style: ButtonStyleColor.cyanColor,
                  textStyle: ButtonTextStyle.buttonStyle1, // Texto branco
                  title: 'Finalizar',
                  onPressed:
                      () => _showSnackBar(context, 'Pequeno 3 pressionado!'),
                ),
              ),
              const SizedBox(height: 32),

              // --- Botões Médios (Medium) ---
              const Text(
                'Botões Médios (Medium)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.medium,
                  style: ButtonStyleColor.orangeColor,
                  textStyle: ButtonTextStyle.buttonStyle1, // Texto branco
                  title: 'Ação Média 1',
                  onPressed:
                      () => _showSnackBar(context, 'Médio 1 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.medium,
                  style: ButtonStyleColor.redColor,
                  textStyle: ButtonTextStyle.buttonStyle2, // Texto preto
                  title: 'Médio c/ Ícone',
                  icon: Icons.favorite,
                  onPressed:
                      () => _showSnackBar(context, 'Médio 2 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.medium,
                  style: ButtonStyleColor.greenColor,
                  textStyle: ButtonTextStyle.buttonStyle1, // Texto branco
                  title: 'Continuar',
                  onPressed:
                      () => _showSnackBar(context, 'Médio 3 pressionado!'),
                ),
              ),
              const SizedBox(height: 32),

              // --- Botões Grandes (Large) ---
              const Text(
                'Botões Grandes (Large)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.large,
                  style: ButtonStyleColor.cyanColor,
                  textStyle: ButtonTextStyle.buttonStyle2, // Texto preto
                  title: 'Botão Grande 1',
                  onPressed:
                      () => _showSnackBar(context, 'Grande 1 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.large,
                  style: ButtonStyleColor.orangeColor,
                  textStyle: ButtonTextStyle.buttonStyle1, // Texto branco
                  title: 'Botão Grande c/ Ícone',
                  icon: Icons.cloud_upload,
                  onPressed:
                      () => _showSnackBar(context, 'Grande 2 pressionado!'),
                ),
              ),
              const SizedBox(height: 8),
              Button.instantiate(
                ButtonViewModel(
                  size: ButtonSize.large,
                  style: ButtonStyleColor.redColor,
                  textStyle: ButtonTextStyle.buttonStyle2, // Texto preto
                  title: 'Confirmar Pedido',
                  onPressed:
                      () => _showSnackBar(context, 'Grande 3 pressionado!'),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
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
