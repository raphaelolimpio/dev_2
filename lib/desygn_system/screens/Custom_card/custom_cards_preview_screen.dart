// lib/desygn_system/screens/custom_cards_preview_screen.dart
import 'package:dev/desygn_system/components/cards/card_Custom/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/components/appbar/appBar_custom.dart'; // Seu AppBar
import 'package:dev/desygn_system/components/cards/card_Custom/custom_card_view_model.dart'; // Seu novo ViewModel
import 'package:dev/desygn_system/shared/color/colors.dart'; // Suas cores

class CustomCardsPreviewScreen extends StatelessWidget {
  const CustomCardsPreviewScreen({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exemplos de Custom Cards',
        backgroundColor: appNormalCyanColor,
      ),
      body: ListView(
        children: [
          // Exemplo 1: Cartão de Evento
          CustomCard(
            viewModel: CustomCardViewModel(
              title: 'Reunião de Projetos',
              subtitle: 'Importante',
              date: '22 de Maio, 2025 - 14:00',
              buttonText: 'Ver Detalhes',
              onButtonPressed: (ctx) {
                _showSnackBar(ctx, 'Ver Detalhes da Reunião!');
                // Navigator.pushNamed(ctx, '/event_details');
              },
            ),
          ),
          // Exemplo 2: Cartão de Lembrete/Tarefa
          CustomCard(
            viewModel: CustomCardViewModel(
              title: 'Pagar Conta de Luz',
              subtitle: 'Atrasada',
              date: 'Vencimento: 20 de Maio, 2025',
              buttonText: 'Pagar Agora',
              onButtonPressed: (ctx) {
                _showSnackBar(ctx, 'Abrindo tela de Pagamento...');
                // showDialog... ou Navigator.push...
              },
            ),
          ),
          // Exemplo 3: Cartão de Notificação
          CustomCard(
            viewModel: CustomCardViewModel(
              title: 'Atualização do Sistema',
              subtitle: 'Nova Versão Disponível',
              date: 'Publicado em 21 de Maio, 2025',
              buttonText: 'Instalar',
              onButtonPressed: (ctx) {
                _showSnackBar(ctx, 'Iniciando instalação da atualização...');
              },
            ),
          ),
          // Exemplo 4: Outro tipo de card (pode ter uma data futura)
          CustomCard(
            viewModel: CustomCardViewModel(
              title: 'Agendamento de Consulta',
              subtitle: 'Confirmado',
              date: '01 de Junho, 2025 - 10:00',
              buttonText: 'Confirmar',
              onButtonPressed: (ctx) {
                _showSnackBar(ctx, 'Consulta Confirmada!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
