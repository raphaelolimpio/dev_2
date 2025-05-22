import 'package:dev/desygn_system/components/cards/base/base_card_view_model.dart';
import 'package:dev/desygn_system/components/cards/card/card.dart'
    as DefaultCardWidget;
import 'package:dev/desygn_system/components/cards/card_Custom/custom_card.dart'
    as CustomCardWidget; // Renomeando para evitar conflito
import 'package:dev/desygn_system/components/cards/enum/card_enums.dart'; // Importe os enums
import 'package:dev/desygn_system/components/cards/card/card_view_model.dart'; // Importe o seu CardViewMode
import 'package:dev/desygn_system/components/cards/card_Custom/custom_card_view_model.dart'; // Importe o seu CustomCardViewModel
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final List<BaseCardViewModel> cards;
  final CardModelType cardModelType;
  final CardDisplayMode displayMode;

  const ListCard({
    super.key,
    required this.cards,
    this.cardModelType = CardModelType.defaultCard,
    this.displayMode = CardDisplayMode.verticalList,
  });

  @override
  Widget build(BuildContext context) {
    // Definir uma largura padrão para cards em rolagem horizontal
    // AJUSTE ESTE VALOR CONFORME O TAMANHO DESEJADO PARA SEUS CARDS HORIZONTAIS
    final double horizontalCardWidth = 280.0; // Exemplo de largura

    // Função auxiliar para renderizar o widget do card correto
    Widget _buildCardWidget(BaseCardViewModel viewModel) {
      switch (cardModelType) {
        case CardModelType.defaultCard:
          if (viewModel is CardViewMode) {
            return DefaultCardWidget.CustomCards(
              viewModel: viewModel,
              cardWidth:
                  displayMode == CardDisplayMode.horizontalScroll
                      ? horizontalCardWidth // Passa a largura para cards horizontais
                      : null, // Não define largura para lista vertical
            );
          }
          return Text('Erro: ViewModel inesperado para Default Card');
        case CardModelType.customCard:
          if (viewModel is CustomCardViewModel) {
            return CustomCardWidget.CustomCard(
              viewModel: viewModel,
              cardWidth:
                  displayMode == CardDisplayMode.horizontalScroll
                      ? horizontalCardWidth // Passa a largura para cards horizontais
                      : null, // Não define largura para lista vertical
            );
          }
          return Text('Erro: ViewModel inesperado para Custom Card');
        default:
          return Text('Tipo de Card não suportado');
      }
    }

    if (displayMode == CardDisplayMode.verticalList) {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return _buildCardWidget(cards[index]);
        },
      );
    } else {
      // displayMode == CardDisplayMode.horizontalScroll
      return SizedBox(
        height: 180, // Mantenha a altura definida para o ListView horizontal
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: _buildCardWidget(cards[index]),
            );
          },
        ),
      );
    }
  }
}
