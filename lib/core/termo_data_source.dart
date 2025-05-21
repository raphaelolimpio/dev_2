// lib/core/termo_data_source.dart
import '../models/termo.dart';

/// Uma interface (classe abstrata) que define as operações CRUD básicas
/// para qualquer fonte de dados de Termos.
/// Isso atua como o "molde de consulta" genérico.
abstract class TermoDataSource {
  /// Retorna todos os termos da fonte de dados, organizados por tema.
  Future<Map<String, List<Termo>>> findAll();

  /// Encontra um termo específico pelo tema e nome na fonte de dados.
  Future<Termo?> findByTemaAndNome(String tema, String nomeTermo);

  /// Adiciona um novo termo ou atualiza um termo existente na fonte de dados.
  /// Retorna true se a operação foi bem-sucedida.
  Future<bool> save(String tema, Termo termo);

  /// Remove um termo específico da fonte de dados pelo tema e nome.
  /// Retorna true se o termo foi removido, false caso contrário.
  Future<bool> deleteByTemaAndNome(String tema, String nomeTermo);

  /// Lista todos os temas disponíveis na fonte de dados.
  Future<List<String>> listThemes();

  /// Lista todos os termos (sem organização por tema, achatado em uma única lista).
  Future<List<Termo>> listAllTermosFlat();
}
