// lib/desygn_system/components/cards/card/custom_card.dart
import 'package:dev/desygn_system/components/cards/card/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import para formatação de moeda
import 'package:dev/desygn_system/shared/style/Style.dart'; // Seus estilos
import 'package:dev/desygn_system/shared/color/colors.dart'; // Suas cores

class CustomCard extends StatelessWidget {
  final CardViewMode viewModel;

  const CustomCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Formatação da moeda
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    final formattedValue = currencyFormatter.format(viewModel.value);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0, // Adiciona uma pequena sombra para destacar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ), // Borda arredondada
      child: InkWell(
        onTap: viewModel.onTap,
        borderRadius: BorderRadius.circular(
          8.0,
        ), // Garante que o InkWell siga a forma do Card
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Aumenta um pouco o padding
          child: Row(
            children: [
              // Imagem / Avatar
              CircleAvatar(
                radius: 30, // Aumenta o tamanho do avatar
                backgroundColor: kGray300, // Cor de fundo para o placeholder
                backgroundImage:
                    viewModel.imageUrl != null && viewModel.imageUrl!.isNotEmpty
                        ? NetworkImage(viewModel.imageUrl!)
                        : null, // Se não tiver URL, não define backgroundImage
                child:
                    viewModel.imageUrl == null || viewModel.imageUrl!.isEmpty
                        ? Icon(
                          Icons.shopping_bag,
                          size: 30,
                          color: kGray600,
                        ) // Ícone de placeholder
                        : null,
              ),
              const SizedBox(width: 16.0),
              // Título e Subtítulo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.title,
                      style: normalStyle.copyWith(
                        // Usando seu estilo
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: kFontColorBlack, // Cor do texto
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      viewModel.subtitle,
                      style: smallStyle.copyWith(
                        // Usando seu estilo
                        color: kGray700, // Cor do texto
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              // Valor e Botão de Diminuir
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end, // Alinha à direita
                children: [
                  Text(
                    formattedValue, // Valor formatado
                    style: normalStyle.copyWith(
                      // Usando seu estilo
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: appNormalCyanColor, // Cor do valor
                    ),
                  ),
                  if (viewModel.onDecrease !=
                      null) // Só mostra se a função for fornecida
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: kRed500,
                      ),
                      onPressed: viewModel.onDecrease,
                      tooltip: 'Diminuir Quantidade', // Dica de ferramenta
                    ),
                ],
              ),
              // Botão de Mais Opções (3 pontos)
              if (viewModel.onMoreOptions !=
                  null) // Só mostra se a função for fornecida
                IconButton(
                  icon: const Icon(Icons.more_vert, color: kGray700),
                  onPressed: viewModel.onMoreOptions,
                  tooltip: 'Mais Opções', // Dica de ferramenta
                ),
            ],
          ),
        ),
      ),
    );
  }
}
