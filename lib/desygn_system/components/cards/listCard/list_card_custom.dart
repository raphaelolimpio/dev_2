import 'package:dev/desygn_system/components/cards/card/card.dart';
import 'package:dev/desygn_system/components/cards/card/card_view_model.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final List<CardViewMode> cards;

  const ListCard({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CustomCard(
          viewModel: cards[index],
          //listOptions: const [
          // Defina as opções do ListButtons aqui, se necessário
          // ],
        );
      },
    );
  }
}
