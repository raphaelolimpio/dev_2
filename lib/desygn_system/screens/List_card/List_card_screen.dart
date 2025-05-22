import 'package:dev/desygn_system/components/cards/enum/card_enums.dart'; // Seus enums
import 'package:dev/desygn_system/components/cards/listCard/list_card_custom.dart'; // Seu ListCard (verificar o nome do arquivo, ajustei para list_card.dart no exemplo anterior)
import 'package:flutter/material.dart';

import 'package:dev/desygn_system/components/cards/card/card_view_model.dart';
import 'package:dev/desygn_system/components/cards/card_Custom/custom_card_view_model.dart';

class ListCardScreen extends StatelessWidget {
  const ListCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardViewMode> defaultCards = [
      CardViewMode(
        title: 'Produto X',
        subtitle: 'Descrição do Produto X',
        value: 120.50,
        imageUrl: 'https://via.placeholder.com/150/FF5733/FFFFFF?text=Prod1',
        onTap: () => print('Clicou no Produto X'),
        onDecrease: () => print('Diminuir Produto X'),
        onMoreOptions: () => print('Mais opções para Produto X'),
      ),
      CardViewMode(
        title: 'Serviço Y',
        subtitle: 'Serviço de alta qualidade',
        value: 300.00,
        imageUrl: null,
        onTap: () => print('Clicou no Serviço Y'),
        onDecrease: null,
        onMoreOptions: () => print('Mais opções para Serviço Y'),
      ),
    ];

    // Exemplo de dados para o CardModelType.customCard
    final List<CustomCardViewModel> customCards = [
      CustomCardViewModel(
        title: 'Notícia Urgente',
        subtitle: 'Novas atualizações sobre o tema X',
        date: '22/05/2025',
        buttonText: 'Ler Mais',
        onButtonPressed:
            (ctx) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Ler Mais Notícia Urgente')),
            ),
      ),
      CustomCardViewModel(
        title: 'Evento Tech',
        subtitle: 'Conferência de desenvolvimento',
        date: '10/06/2025',
        buttonText: 'Inscrever-se',
        onButtonPressed:
            (ctx) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Inscrever-se no Evento Tech')),
            ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Cards Flexíveis')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cards Padrão (Lista Vertical)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Exibindo Cards Padrão em lista vertical
            SizedBox(
              // ListView.builder dentro de um Column precisa de altura definida
              height: 300, // Ajuste conforme necessário
              child: ListCard(
                cards: defaultCards, // Passando a lista de defaultCards
                cardModelType:
                    CardModelType.defaultCard, // Especificando o tipo de card
                displayMode:
                    CardDisplayMode
                        .verticalList, // Especificando o modo de visualização
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cards Customizados (Lista Horizontal)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Exibindo Cards Customizados em lista horizontal
            ListCard(
              cards: customCards, // Passando a lista de customCards
              cardModelType:
                  CardModelType.customCard, // Especificando o tipo de card
              displayMode:
                  CardDisplayMode
                      .horizontalScroll, // Especificando o modo de visualização
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Mais Cards Padrão (Lista Horizontal - Exemplo Netflix)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListCard(
              cards: [
                CardViewMode(
                  title: 'Destaque 1',
                  subtitle: 'Filme novo',
                  value: 0.0,
                  imageUrl:
                      'https://via.placeholder.com/150/FF5733/FFFFFF?text=Film1',
                  onTap: () => print('Destaque 1'),
                ),
                CardViewMode(
                  title: 'Destaque 2',
                  subtitle: 'Série imperdível',
                  value: 0.0,
                  imageUrl:
                      'https://via.placeholder.com/150/33FF57/FFFFFF?text=Serie1',
                  onTap: () => print('Destaque 2'),
                ),
                CardViewMode(
                  title: 'Destaque 3',
                  subtitle: 'Documentário',
                  value: 0.0,
                  imageUrl:
                      'https://via.placeholder.com/150/5733FF/FFFFFF?text=Doc1',
                  onTap: () => print('Destaque 3'),
                ),
              ],
              cardModelType: CardModelType.defaultCard,
              displayMode: CardDisplayMode.horizontalScroll,
            ),
            // Você pode adicionar mais ListCards aqui com diferentes configurações
          ],
        ),
      ),
    );
  }
}
