// lib/repositories/termo_repository.dart
import '../models/termo.dart';
import '../core/termo_data_source.dart'; // Importa a interface

/// Um repositório que abstrai a fonte de dados concreta para termos.
/// Ele usa uma implementação de TermoDataSource para realizar as operações.
class TermoRepository {
  final TermoDataSource _dataSource; // Agora ele depende da interface

  // O construtor recebe a implementação da fonte de dados (ex: LocalTermoDataSource)
  TermoRepository(this._dataSource);

  // --- Operações CRUD (Delegam para o dataSource) ---

  Future<Map<String, List<Termo>>> findAll() {
    return _dataSource.findAll();
  }

  Future<Termo?> findByTemaAndNome(String tema, String nomeTermo) {
    return _dataSource.findByTemaAndNome(tema, nomeTermo);
  }

  Future<bool> save(String tema, Termo termo) {
    return _dataSource.save(tema, termo);
  }

  Future<bool> deleteByTemaAndNome(String tema, String nomeTermo) {
    return _dataSource.deleteByTemaAndNome(tema, nomeTermo);
  }

  Future<List<String>> listThemes() {
    return _dataSource.listThemes();
  }

  Future<List<Termo>> listAllTermosFlat() {
    return _dataSource.listAllTermosFlat();
  }
}
