// test/integration/data_layer_integration_test.dart
import 'dart:io';
import 'package:dev/core/json_file_mananger.dart';
import 'package:flutter_test/flutter_test.dart'; // Importa flutter_test para TestWidgetsFlutterBinding
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart'; // Importa MockPlatformInterfaceMixin
import 'package:mockito/mockito.dart'; // Importa Mock para a classe MockPathProviderPlatform

// Importa as classes reais, não os mocks

import 'package:dev/data/local_termo_data_source.dart';
import 'package:dev/repositories/termo_repository.dart';
import 'package:dev/models/termo.dart';

// --- Mock para path_provider para testes de integração ---
// Esta classe simula o comportamento de path_provider para retornar um diretório temporário.
class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return Directory.systemTemp.createTempSync().path;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return Directory.systemTemp.createTempSync().path;
  }

  // --- Implementações de TODOS os métodos abstratos de PathProviderPlatform ---
  // Adicionados para resolver os erros de "Missing concrete implementation"
  @override
  Future<String?> getApplicationCachePath() async {
    return Future.value(null);
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return Future.value(null);
  }

  @override
  Future<String?> getDownloadsPath() async {
    return Future.value(null);
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return Future.value([]);
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return Future.value([]);
  }

  @override
  Future<String?> getLibraryPath() async {
    return Future.value(null);
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return Future.value(null);
  }

  // --- Fim das implementações ---
}
// --- Fim do Mock para path_provider ---

void main() {
  // CRUCIAL: Inicializa o binding do Flutter para que rootBundle e outros serviços funcionem
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir; // Diretório temporário para os arquivos de teste
  late String tempFilePath;
  late JsonFileManager jsonFileManager;
  late LocalTermoDataSource termoDataSource;
  late TermoRepository termoRepository;

  // Path do asset de teste que criamos
  const testAssetPath = 'assets/test_data_for_integration.json';
  const testFileName = 'integration_test_data.json';

  // Configurações antes de todos os testes
  setUpAll(() async {
    // Injeta o mock do path_provider para controlar o diretório temporário
    PathProviderPlatform.instance = MockPathProviderPlatform();

    // Cria um diretório temporário para os testes
    tempDir = await Directory.systemTemp.createTemp('integration_test_');
    tempFilePath = tempDir.path;

    // Instancia o JsonFileManager com o diretório temporário
    jsonFileManager = JsonFileManager(basePath: tempFilePath);

    // Copia o asset de teste para o diretório temporário
    await jsonFileManager.copyAssetToLocal(testAssetPath, testFileName);

    // Instancia as classes reais usando o JsonFileManager configurado
    termoDataSource = LocalTermoDataSource(testFileName, jsonFileManager);
    termoRepository = TermoRepository(termoDataSource);
  });

  // Limpeza após todos os testes
  tearDownAll(() async {
    // Remove o diretório temporário e todos os arquivos nele
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('Data Layer Integration Test', () {
    test('should correctly read data from the actual JSON file', () async {
      final result = await termoRepository.findAll();

      expect(result.length, 2);
      expect(result.keys, contains('TemaTeste1'));
      expect(result.keys, contains('TemaTeste2'));
      expect(result['TemaTeste1']!.first.nome, 'TermoA');
      expect(result['TemaTeste2']!.first.nome, 'TermoB');
    });

    test('should correctly save new data to the actual JSON file', () async {
      final newTermo = Termo(
        nome: 'TermoC',
        categoria: 'Cat3',
        definicao: 'Definicao do Termo C',
        tema: 'TemaTeste1', // Adicionar a um tema existente
      );

      final success = await termoRepository.save('TemaTeste1', newTermo);
      expect(success, isTrue);

      // Agora, leia o arquivo novamente para verificar se o termo foi salvo
      final updatedData = await termoRepository.findAll();
      expect(updatedData['TemaTeste1']!.length, 2);
      expect(updatedData['TemaTeste1'], contains(newTermo));
    });

    test('should correctly delete data from the actual JSON file', () async {
      final success = await termoRepository.deleteByTemaAndNome(
        'TemaTeste1',
        'TermoA',
      );
      expect(success, isTrue);

      // Leia o arquivo novamente para verificar a exclusão
      final updatedData = await termoRepository.findAll();
      expect(updatedData['TemaTeste1']!.length, 1); // Apenas TermoC deve restar
      expect(
        updatedData['TemaTeste1'],
        isNot(
          contains(
            Termo(
              nome: 'TermoA',
              categoria: 'Cat1',
              definicao: 'Definicao do Termo A',
              tema: 'TemaTeste1',
            ),
          ),
        ),
      ); // Verifique se TermoA foi removido
    });
  });
}
