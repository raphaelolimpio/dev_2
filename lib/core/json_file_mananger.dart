import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle; // Para assets
import 'package:path_provider/path_provider.dart'; // Para diretórios de app

class JsonFileManager {
  final String? _basePath; // Torna o caminho base injetável

  // Construtor opcional para injeção de caminho base para testes
  JsonFileManager({String? basePath}) : _basePath = basePath;

  Future<String> get _localPath async {
    if (_basePath != null) {
      return _basePath!; // Retorna o caminho injetado se presente
    }
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // O restante dos seus métodos (readJson, writeJson, fileExists, copyAssetToLocal)
  // DEVE USAR _localPath para construir o caminho completo do arquivo.

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<Map<String, dynamic>> readJson(String fileName) async {
    try {
      final file = await _localFile(fileName);
      if (!await file.exists()) {
        return {}; // Retorna mapa vazio se o arquivo não existe
      }
      final contents = await file.readAsString();
      return json.decode(contents) as Map<String, dynamic>;
    } catch (e) {
      //print("Erro ao ler JSON de $fileName: $e");
      return {}; // Retorna um mapa vazio em caso de erro
    }
  }

  Future<File> writeJson(String fileName, Map<String, dynamic> jsonMap) async {
    final file = await _localFile(fileName);
    final String jsonString = json.encode(jsonMap);
    return file.writeAsString(jsonString);
  }

  Future<bool> fileExists(String fileName) async {
    final file = await _localFile(fileName);
    return file.exists();
  }

  Future<void> copyAssetToLocal(String assetPath, String localFileName) async {
    try {
      final String contents = await rootBundle.loadString(assetPath);
      final file = await _localFile(localFileName);
      await file.writeAsString(contents);
    } catch (e) {
      //print("Erro ao copiar asset $assetPath para $localFileName: $e");
      rethrow; // Relança a exceção para que o chamador possa tratá-la
    }
  }
}
