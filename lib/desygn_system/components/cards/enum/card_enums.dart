// lib/desygn_system/components/cards/card_enums.dart

/// Define os diferentes modelos de cards que podem ser exibidos.
enum CardModelType {
  /// O modelo de card padrão com imagem, valor e botões de ação.
  defaultCard,

  /// O modelo de card customizado com título, subtítulo, data e botão.
  customCard,
  // Adicione outros modelos de card aqui conforme necessário.
}

/// Define os diferentes modos de visualização para a lista de cards.
enum CardDisplayMode {
  /// Visualização padrão em lista vertical (um card abaixo do outro).
  verticalList,

  /// Visualização em lista horizontal (cards lado a lado com rolagem).
  horizontalScroll,
}
