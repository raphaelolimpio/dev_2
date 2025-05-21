// test/core/json_file_manager_test.dart
import 'dart:io';
import 'package:dev/core/json_file_mananger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/services.dart'; // Para rootBundle
import 'dart:convert'; // Para json.decode e json.encode

// Ajuste o caminho conforme seu projeto

// --- Mock para PathProvider (essencial para testes) ---
// Isso simula o comportamento do path_provider sem depender do ambiente de dispositivo
class MockPathProviderPlatform
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  String _tempPath = '';

  @override
  Future<String?> getTemporaryPath() => Future.value(_tempPath);

  @override
  Future<String?> getApplicationSupportPath() => Future.value(_tempPath);

  @override
  Future<String?> getLibraryPath() => Future.value(_tempPath);

  @override
  Future<String?> getApplicationDocumentsPath() => Future.value(_tempPath);

  @override
  Future<String?> getExternalStoragePath() => Future.value(_tempPath);

  @override
  Future<List<String>?> getExternalCachePaths() => Future.value([]);

  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) =>
      Future.value([]);

  @override
  Future<String?> getDownloadsPath() => Future.value(_tempPath);

  // --- MÉTODO FALTANTE ADICIONADO AQUI ---
  @override
  Future<String?> getApplicationCachePath() => Future.value(_tempPath);

  // Método auxiliar para definir o caminho temporário para os testes
  void setTempPath(String path) {
    _tempPath = path;
  }
}

void main() {
  late JsonFileManager jsonFileManager;
  late MockPathProviderPlatform mockPathProvider;
  late String testDir;

  setUp(() async {
    // Configura um diretório temporário para os testes de arquivo
    testDir = Directory.systemTemp.createTempSync().path;
    print('Diretório de teste temporário: $testDir'); // Para depuração

    mockPathProvider = MockPathProviderPlatform();
    mockPathProvider.setTempPath(testDir);
    PathProviderPlatform.instance = mockPathProvider;

    jsonFileManager = JsonFileManager();

    // Mockar o rootBundle para carregar assets em testes de unidade
    TestWidgetsFlutterBinding.ensureInitialized(); // Necessário para usar rootBundle
    // Mocar o asset "assets/test_asset.json"
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
          if (message != null) {
            final String key = utf8.decode(message.buffer.asUint8List());
            if (key == 'assets/test_asset.json') {
              return ByteData.view(
                utf8.encode('{"key_from_asset": "value_from_asset"}').buffer,
              );
            }
          }
          return null;
        });
  });

  tearDown(() async {
    // Limpa o diretório temporário após cada teste
    try {
      if (await Directory(testDir).exists()) {
        await Directory(testDir).delete(recursive: true);
      }
    } catch (e) {
      print('Erro ao deletar diretório temporário: $e');
    }
  });

  group('JsonFileManager', () {
    test('should read JSON from an asset', () async {
      final data = await jsonFileManager.readJson(
        'assets/test_asset.json',
        //fromAsset: true,
      );
      expect(data, isA<Map<String, dynamic>>());
      expect(data['key_from_asset'], 'value_from_asset');
    });

    test('should write and read JSON to/from a local file', () async {
      final testFileName = 'test_local_file.json';
      final testData = {'name': 'Test Term', 'category': 'Testing'};

      // Escrever o JSON
      await jsonFileManager.writeJson(testFileName, testData);

      // Verificar se o arquivo foi criado e tem conteúdo
      final file = File('$testDir/$testFileName');
      expect(await file.exists(), isTrue);
      expect(await file.readAsString(), jsonEncode(testData));

      // Ler o JSON
      final readData = await jsonFileManager.readJson(testFileName);
      expect(readData, isA<Map<String, dynamic>>());
      expect(readData['name'], 'Test Term');
      expect(readData['category'], 'Testing');
    });

    test(
      'should return empty map if local file does not exist initially',
      () async {
        final testFileName = 'non_existent_file.json';
        final data = await jsonFileManager.readJson(testFileName);
        expect(data, {}); // Deve retornar um mapa vazio
        // E deve ter criado o arquivo vazio
        final file = File('$testDir/$testFileName');
        expect(await file.exists(), isTrue);
        expect(await file.readAsString(), '{}');
      },
    );

    test('should handle invalid JSON in local file gracefully', () async {
      final invalidFileName = 'invalid.json';
      final file = File('$testDir/$invalidFileName');
      await file.writeAsString(
        '{"key": "value", "invalid":}',
      ); // JSON malformado
      final data = await jsonFileManager.readJson(invalidFileName);
      expect(data, {}); // Deve retornar um mapa vazio em caso de JSON inválido
    });

    test('should copy asset to local storage', () async {
      final assetPath = 'assets/test_asset.json';
      final localFileName = 'copied_asset.json';

      await jsonFileManager.copyAssetToLocal(assetPath, localFileName);

      final file = File('$testDir/$localFileName');
      expect(await file.exists(), isTrue);
      final content = await file.readAsString();
      expect(jsonDecode(content), {'key_from_asset': 'value_from_asset'});
    });

    test('fileExists should return true for existing file', () async {
      final testFileName = 'existing.json';
      final file = File('$testDir/$testFileName');
      await file.writeAsString('{}'); // Cria um arquivo vazio
      expect(await jsonFileManager.fileExists(testFileName), isTrue);
    });

    test('fileExists should return false for non-existing file', () async {
      final testFileName = 'non_existing.json';
      expect(await jsonFileManager.fileExists(testFileName), isFalse);
    });
  });
}
