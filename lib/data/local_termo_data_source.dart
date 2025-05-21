// lib/data/local_termo_data_source.dart
import 'package:dev/core/json_file_mananger.dart';
import '../models/termo.dart';
import '../core/termo_data_source.dart';

/// Uma implementação de TermoDataSource que opera em um arquivo JSON local.
class LocalTermoDataSource implements TermoDataSource {
  final JsonFileManager _fileManager;
  final String _fileName;

  // CONSTRUTOR ATUALIZADO PARA INJEÇÃO DE DEPENDÊNCIA DO JsonFileManager
  LocalTermoDataSource(this._fileName, this._fileManager); // <--- MUDANÇA AQUI!

  // --- Métodos de Conversão de/para Termo ---
  // ... (o restante da sua classe é o mesmo) ...

  /// Converte o mapa JSON bruto para Map<String, List<Termo>>.
  Map<String, List<Termo>> _decodeJsonToTermos(
    Map<String, dynamic> jsonRawData,
  ) {
    final Map<String, List<Termo>> termosMap = {};
    jsonRawData.forEach((key, value) {
      if (value is List) {
        termosMap[key] =
            value
                .map((e) => Termo.fromJson(e as Map<String, dynamic>))
                .toList();
      }
    });
    return termosMap;
  }

  /// Converte Map<String, List<Termo>> para um mapa JSON serializável.
  Map<String, dynamic> _encodeTermosToJson(Map<String, List<Termo>> data) {
    return data.map(
      (key, value) =>
          MapEntry(key, value.map((termo) => termo.toJson()).toList()),
    );
  }

  // --- Implementação dos métodos da interface TermoDataSource ---

  @override
  Future<Map<String, List<Termo>>> findAll() async {
    final jsonRawData = await _fileManager.readJson(_fileName);
    return _decodeJsonToTermos(jsonRawData);
  }

  @override
  Future<Termo?> findByTemaAndNome(String tema, String nomeTermo) async {
    final data = await findAll();
    if (data.containsKey(tema)) {
      try {
        return data[tema]!.firstWhere(
          (t) => t.nome.toLowerCase() == nomeTermo.toLowerCase(),
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<bool> save(String tema, Termo termo) async {
    try {
      final data = await findAll();
      List<Termo> termosDoTema = data.putIfAbsent(tema, () => []);

      final index = termosDoTema.indexWhere(
        (t) => t.nome.toLowerCase() == termo.nome.toLowerCase(),
      );
      if (index != -1) {
        termosDoTema[index] = termo;
      } else {
        termosDoTema.add(termo);
      }
      await _fileManager.writeJson(_fileName, _encodeTermosToJson(data));
      return true;
    } catch (e) {
      print('LocalTermoDataSource: Erro ao salvar termo no $_fileName: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteByTemaAndNome(String tema, String nomeTermo) async {
    try {
      final data = await findAll();
      if (data.containsKey(tema)) {
        final initialLength = data[tema]!.length;
        data[tema]!.removeWhere(
          (t) => t.nome.toLowerCase() == nomeTermo.toLowerCase(),
        );
        if (data[tema]!.isEmpty) {
          data.remove(tema);
        }
        if (data[tema]?.length != initialLength) {
          // Verifica se houve remoção real
          await _fileManager.writeJson(_fileName, _encodeTermosToJson(data));
          return true;
        }
      }
      return false;
    } catch (e) {
      print('LocalTermoDataSource: Erro ao deletar termo do $_fileName: $e');
      return false;
    }
  }

  @override
  Future<List<String>> listThemes() async {
    final data = await findAll();
    return data.keys.toList();
  }

  @override
  Future<List<Termo>> listAllTermosFlat() async {
    final data = await findAll();
    List<Termo> allTermos = [];
    data.values.forEach((list) => allTermos.addAll(list));
    return allTermos;
  }
}
