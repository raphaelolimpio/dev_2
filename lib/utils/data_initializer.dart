// lib/core/data_initializer.dart
// Certifique-se que o import está correto

import 'package:dev/core/json_file_mananger.dart';

/// Utilitário para inicializar e garantir que os arquivos JSON de dados
/// estejam presentes no armazenamento local do aplicativo.
class DataInitializer {
  final JsonFileManager _fileManager; // Agora não é mais inicializado aqui

  // CONSTRUTOR ATUALIZADO PARA INJEÇÃO DE DEPENDÊNCIA
  DataInitializer(this._fileManager); // <--- MUDANÇA AQUI!

  static const String _principalAssetPath = 'assets/principal.json';
  static const String _validacaoAssetPath = 'assets/validacao.json';
  static const String _reavaliacaoAssetPath = 'assets/revalidacao.json';

  static const String _principalFileName = 'principal.json';
  static const String _validacaoFileName = 'validacao.json';
  static const String _reavaliacaoFileName = 'reavaliacao.json';

  /// Garante que os arquivos JSON locais existam, copiando-os dos assets se necessário.
  Future<void> ensureLocalFilesExist() async {
    final assetsToCopy = {
      _principalAssetPath: _principalFileName,
      _validacaoAssetPath: _validacaoFileName,
      _reavaliacaoAssetPath: _reavaliacaoFileName,
    };

    for (var entry in assetsToCopy.entries) {
      final assetPath = entry.key;
      final localFileName = entry.value;

      final bool fileExists = await _fileManager.fileExists(localFileName);
      // Alteração: readJson pode retornar um mapa vazio se o arquivo não existir ou for vazio,
      // mas `readJson` deve ser mockado para retornar um mapa vazio ou com dados válidos.
      // A condição `localContent.isEmpty` é boa para verificar se o arquivo está vazio.
      final Map<String, dynamic> localContent = await _fileManager.readJson(
        localFileName,
      );

      if (!fileExists || localContent.isEmpty) {
        try {
          await _fileManager.copyAssetToLocal(assetPath, localFileName);
        } catch (e) {
          print(
            // Use um logger real em produção, mas print é ok para este contexto de exemplo
            'DataInitializer: Falha ao inicializar o arquivo $localFileName: $e',
          );
        }
      } else {
        print(
          'DataInitializer: Arquivo $localFileName já existe e não está vazio.',
        );
      }
    }
  }
}
