// lib/services/principal_termo_service.dart
import '../models/termo.dart';
import '../repositories/termo_repository.dart';

/// Serviço responsável por gerenciar a busca e listagem de temas
/// a partir do arquivo JSON principal.
class PrincipalTermoService {
  final TermoRepository _principalRepository;

  // CONSTRUTOR ATUALIZADO: Agora recebe o TermoRepository injetado
  PrincipalTermoService(this._principalRepository);

  /// Busca termos no arquivo principal com base em filtros.
  Future<List<Termo>> buscarTermos({
    String? tema,
    String? nome,
    String? categoria,
  }) async {
    final data = await _principalRepository.findAll();
    List<Termo> resultados = [];

    data.forEach((t, termosDoTema) {
      for (var termo in termosDoTema) {
        bool matchesTema =
            tema == null ||
            (termo.tema != null &&
                termo.tema!.toLowerCase() == tema.toLowerCase());
        bool matchesNome =
            nome == null ||
            termo.nome.toLowerCase().contains(nome.toLowerCase());
        bool matchesCategoria =
            categoria == null ||
            termo.categoria.toLowerCase() == categoria.toLowerCase();

        if (matchesTema && matchesNome && matchesCategoria) {
          resultados.add(termo);
        }
      }
    });
    return resultados;
  }

  /// Lista todos os temas disponíveis no arquivo principal.
  Future<List<String>> getTemas() async {
    return await _principalRepository.listThemes();
  }

  /// Adiciona ou atualiza um termo no arquivo principal.
  Future<String> addOrUpdatePrincipalTermo(String tema, Termo termo) async {
    final success = await _principalRepository.save(tema, termo);
    return success
        ? "Termo salvo no arquivo principal."
        : "Falha ao salvar termo no principal.";
  }

  /// Remove um termo do arquivo principal.
  Future<String> removePrincipalTermo(String tema, String nome) async {
    final success = await _principalRepository.deleteByTemaAndNome(tema, nome);
    return success
        ? "Termo removido do arquivo principal."
        : "Falha ao remover termo do principal.";
  }
}
