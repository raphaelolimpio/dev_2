import 'package:dev/desygn_system/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dev/desygn_system/shared/style/Style.dart';
import 'package:dev/desygn_system/shared/color/colors.dart';

class CustomCard extends StatelessWidget {
  final CustomCardViewModel viewModel;
  // Adicione um parâmetro opcional para largura, útil para listas horizontais
  final double? cardWidth; // <- NOVO

  const CustomCard({
    super.key,
    required this.viewModel,
    this.cardWidth, // <- NOVO
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        // <- ENVOLVA O CONTAINER COM UM SIZEDBOX
        width: cardWidth, // <- APLICA A LARGURA SE FORNECIDA
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: kFontColorWhite,
            border: Border.all(color: kGray300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: kGray500.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // Este Expanded está ok, desde que o pai (Row) tenha largura definida
                    child: Text(
                      viewModel.title,
                      style: headingStyle.copyWith(
                        fontSize: 18.0,
                        color: kFontColorBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    viewModel.subtitle,
                    style: normalStyle.copyWith(color: kGray700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      viewModel.date,
                      style: smallStyle.copyWith(color: kGray600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.onButtonPressed(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      textStyle: normalStyle.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: appNormalCyanColor,
                      foregroundColor: kFontColorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(viewModel.buttonText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
