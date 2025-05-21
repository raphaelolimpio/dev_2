// lib/desygn_system/components/cards/card/card_view_model.dart
// Este arquivo permanece como você forneceu.
class CardViewMode {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Function()? onTap;
  final double value;
  final Function()? onDecrease;
  final Function()? onMoreOptions; // Será usado para o botão de 3 pontos

  CardViewMode({
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.value,
    this.onTap,
    this.onDecrease,
    this.onMoreOptions,
  });
}
