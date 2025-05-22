// lib/desygn_system/components/cards/card_Custom/custom_card_view_model.dart
import 'package:dev/desygn_system/components/cards/base/base_card_view_model.dart';
import 'package:flutter/material.dart';

class CustomCardViewModel extends BaseCardViewModel {
  final String title;
  final String subtitle;
  final String date;
  final String buttonText;
  final void Function(BuildContext context) onButtonPressed;

  CustomCardViewModel({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.buttonText,
    required this.onButtonPressed,
  });
}
