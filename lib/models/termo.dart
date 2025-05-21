class Termo {
  String nome;
  String categoria;
  String definicao;
  String? comandoExemplo;
  String? explicacaoPratica;
  String? dicasDeUso;
  String? tema;

  Termo({
    required this.nome,
    required this.categoria,
    required this.definicao,
    this.comandoExemplo,
    this.explicacaoPratica,
    this.dicasDeUso,
    this.tema,
  });

  factory Termo.fromJson(Map<String, dynamic> json) {
    return Termo(
      nome: json['nome'] as String,
      categoria: json['categoria'] as String,
      definicao: json['definicao'] as String,
      comandoExemplo: json['comando_exemplo'] as String?,
      explicacaoPratica: json['explicacao_pratica'] as String?,
      dicasDeUso: json['dicas_de_uso'] as String?,
      tema: json['tema'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'definicao': definicao,
      'comando_exemplo': comandoExemplo,
      'explicacao_pratica': explicacaoPratica,
      'dicas_de_uso': dicasDeUso,
      'tema': tema,
    };
  }

  @override
  String toString() {
    return 'Termo(nome: $nome, categoria: $categoria, tema: $tema)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Termo &&
        other.nome == nome &&
        other.categoria == categoria &&
        other.definicao == definicao &&
        other.comandoExemplo == comandoExemplo &&
        other.explicacaoPratica == explicacaoPratica &&
        other.dicasDeUso == dicasDeUso &&
        other.tema == tema;
  }

  @override
  int get hashCode {
    return Object.hash(
      nome,
      categoria,
      definicao,
      comandoExemplo,
      explicacaoPratica,
      dicasDeUso,
      tema,
    );
  }
}
