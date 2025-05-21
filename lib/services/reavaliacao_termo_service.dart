// lib/services/reavaliacao_termo_service.dart
import '../models/termo.dart';
import '../repositories/termo_repository.dart';
import 'validacao_termo_service.dart'; // Mantém a importação

/// Serviço responsável por gerenciar termos para reavaliação.
class ReavaliacaoTermoService {
  final TermoRepository _reavaliacaoRepository;
  // A instância de ValidacaoTermoService agora será injetada no construtor
  // ao invés de usar o método setValidacaoService().
  final ValidacaoTermoService
  _validacaoService; // Removido o '?' e a lógica de set

  // CONSTRUTOR ATUALIZADO: Recebe as dependências injetadas
  ReavaliacaoTermoService(this._reavaliacaoRepository, this._validacaoService);

  /// Lista todos os termos que estão na fila de reavaliação.
  Future<Map<String, List<Termo>>> listarTermosParaReavaliacao() async {
    return await _reavaliacaoRepository.findAll();
  }

  /// Adiciona um novo termo para ser reavaliado.
  Future<String> adicionarTermoParaReavaliacao(
    String tema,
    Termo novoTermo,
  ) async {
    final success = await _reavaliacaoRepository.save(tema, novoTermo);
    return success
        ? "Termo adicionado para reavaliação no tema: $tema"
        : "Erro ao adicionar termo para reavaliação.";
  }

  /// Atualiza um termo existente na fila de reavaliação.
  Future<String> atualizarTermoReavaliacao(
    String tema,
    String nome,
    Termo termoAtualizado,
  ) async {
    final success = await _reavaliacaoRepository.save(tema, termoAtualizado);
    return success
        ? "Termo atualizado com sucesso em reavaliação."
        : "Erro ao atualizar termo em reavaliação.";
  }

  /// Remove um termo da fila de reavaliação.
  Future<String> removerTermoReavaliacao(String tema, String nome) async {
    final success = await _reavaliacaoRepository.deleteByTemaAndNome(
      tema,
      nome,
    );
    return success
        ? "Termo removido com sucesso de reavaliação."
        : "Erro ao remover termo de reavaliação.";
  }

  /// Reenvia um termo da reavaliação de volta para a validação.
  Future<String> reenviarTermoParaValidacao(String tema, String nome) async {
    final termoParaReenviar = await _reavaliacaoRepository.findByTemaAndNome(
      tema,
      nome,
    );
    if (termoParaReenviar == null) {
      return "Termo não encontrado para reenviar.";
    }

    final removeSuccess = await _reavaliacaoRepository.deleteByTemaAndNome(
      tema,
      nome,
    );
    if (!removeSuccess) {
      return "Falha ao remover termo da reavaliação para reenviar.";
    }

    if (termoParaReenviar.tema == null || termoParaReenviar.tema!.isEmpty) {
      termoParaReenviar.tema = tema;
    }
    final addSuccess = await _validacaoService.adicionarTermoParaValidacao(
      tema,
      termoParaReenviar,
    );
    if (!addSuccess.contains("sucesso")) {
      await _reavaliacaoRepository.save(tema, termoParaReenviar);
      return "Falha ao mover termo para validação: $addSuccess";
    }

    return "Termo reenviado para validação.";
  }
}
