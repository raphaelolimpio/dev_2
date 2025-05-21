// lib/services/validacao_termo_service.dart
import '../models/termo.dart';
import '../repositories/termo_repository.dart';
// Note que as importações de PrincipalTermoService e ReavaliacaoTermoService não mudam,
// mas a forma como são recebidas (injeção via construtor) sim.
import 'principal_termo_service.dart';
import 'reavaliacao_termo_service.dart';

/// Serviço responsável por gerenciar termos para validação.
/// Inclui operações de CRUD para termos em validação e transições para
/// arquivos principal e de reavaliação.
class ValidacaoTermoService {
  final TermoRepository _validacaoRepository;
  final PrincipalTermoService _principalService;
  final ReavaliacaoTermoService _reavaliacaoService;

  // CONSTRUTOR ATUALIZADO: Recebe todas as dependências injetadas
  ValidacaoTermoService(
    this._validacaoRepository,
    this._principalService,
    this._reavaliacaoService,
  );

  /// Lista todos os termos que estão na fila de validação.
  Future<Map<String, List<Termo>>> listarTermosParaValidacao() async {
    return await _validacaoRepository.findAll();
  }

  /// Adiciona um novo termo para ser validado.
  Future<String> adicionarTermoParaValidacao(
    String tema,
    Termo novoTermo,
  ) async {
    final success = await _validacaoRepository.save(tema, novoTermo);
    return success
        ? "Termo adicionado para validação no tema: $tema"
        : "Erro ao adicionar termo para validação.";
  }

  /// Atualiza um termo existente na fila de validação.
  Future<String> atualizarTermoValidacao(
    String tema,
    String nome,
    Termo termoAtualizado,
  ) async {
    final success = await _validacaoRepository.save(tema, termoAtualizado);
    return success
        ? "Termo atualizado com sucesso em validação."
        : "Erro ao atualizar termo em validação.";
  }

  /// Remove um termo da fila de validação.
  Future<String> removerTermoValidacao(String tema, String nome) async {
    final success = await _validacaoRepository.deleteByTemaAndNome(tema, nome);
    return success
        ? "Termo removido com sucesso de validação."
        : "Erro ao remover termo de validação.";
  }

  /// Aprova um termo, movendo-o da validação para o arquivo principal.
  Future<String> aprovarTermo(String tema, String nome) async {
    final termoAprovado = await _validacaoRepository.findByTemaAndNome(
      tema,
      nome,
    );
    if (termoAprovado == null) {
      return "Termo não encontrado para aprovação.";
    }

    final removeSuccess = await _validacaoRepository.deleteByTemaAndNome(
      tema,
      nome,
    );
    if (!removeSuccess) {
      return "Falha ao remover termo da validação para aprovação.";
    }

    if (termoAprovado.tema == null || termoAprovado.tema!.isEmpty) {
      termoAprovado.tema = tema;
    }
    final addSuccess = await _principalService.addOrUpdatePrincipalTermo(
      tema,
      termoAprovado,
    );
    if (!addSuccess.contains("sucesso")) {
      await _validacaoRepository.save(tema, termoAprovado);
      return "Falha ao mover termo para o arquivo principal: $addSuccess";
    }

    return "Termo aprovado e movido para o arquivo principal.";
  }

  /// Reprova um termo, movendo-o da validação para o arquivo de reavaliação.
  Future<String> reprovarTermo(String tema, String nome) async {
    final termoReprovado = await _validacaoRepository.findByTemaAndNome(
      tema,
      nome,
    );
    if (termoReprovado == null) {
      return "Termo não encontrado para reprovação.";
    }

    final removeSuccess = await _validacaoRepository.deleteByTemaAndNome(
      tema,
      nome,
    );
    if (!removeSuccess) {
      return "Falha ao remover termo da validação para reprovação.";
    }

    if (termoReprovado.tema == null || termoReprovado.tema!.isEmpty) {
      termoReprovado.tema = tema;
    }
    final addSuccess = await _reavaliacaoService.adicionarTermoParaReavaliacao(
      tema,
      termoReprovado,
    );
    if (!addSuccess.contains("sucesso")) {
      await _validacaoRepository.save(tema, termoReprovado);
      return "Falha ao mover termo para o arquivo de reavaliação: $addSuccess";
    }

    return "Termo reprovado e movido para o arquivo de reavaliação.";
  }
}
