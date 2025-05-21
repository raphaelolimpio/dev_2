// test/core/data_initializer_test.dart
import 'package:dev/core/json_file_mananger.dart';
import 'package:dev/utils/data_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Gerar o mock para JsonFileManager
@GenerateMocks([JsonFileManager])
import 'data_initializer_test.mocks.dart'; // Arquivo gerado automaticamente

void main() {
  late DataInitializer dataInitializer;
  late MockJsonFileManager mockJsonFileManager;

  // Caminhos dos arquivos como definidos na classe DataInitializer
  const principalAssetPath = 'assets/principal.json';
  const validacaoAssetPath = 'assets/validacao.json';
  const reavaliacaoAssetPath = 'assets/revalidacao.json';

  const principalFileName = 'principal.json';
  const validacaoFileName = 'validacao.json';
  const reavaliacaoFileName = 'reavaliacao.json';

  setUp(() {
    mockJsonFileManager = MockJsonFileManager();
    // Injeta o mock do JsonFileManager no DataInitializer
    dataInitializer = DataInitializer(mockJsonFileManager);
  });

  group('DataInitializer', () {
    test('should copy assets to local storage if files do not exist', () async {
      // Configura o mock para simular que nenhum arquivo local existe inicialmente
      when(mockJsonFileManager.fileExists(any)).thenAnswer((_) async => false);
      // E que a leitura retorna um mapa vazio (ou um erro que pode ser tratado)
      when(mockJsonFileManager.readJson(any)).thenAnswer((_) async => {});

      // Simula que a cópia de assets é bem-sucedida
      when(
        mockJsonFileManager.copyAssetToLocal(any, any),
      ).thenAnswer((_) async => null);

      await dataInitializer.ensureLocalFilesExist();

      // Verifica se fileExists foi chamado para todos os arquivos
      verify(mockJsonFileManager.fileExists(principalFileName)).called(1);
      verify(mockJsonFileManager.fileExists(validacaoFileName)).called(1);
      verify(mockJsonFileManager.fileExists(reavaliacaoFileName)).called(1);

      // Verifica se readJson foi chamado para todos os arquivos
      verify(mockJsonFileManager.readJson(principalFileName)).called(1);
      verify(mockJsonFileManager.readJson(validacaoFileName)).called(1);
      verify(mockJsonFileManager.readJson(reavaliacaoFileName)).called(1);

      // Verifica se copyAssetToLocal foi chamado para todos os arquivos
      verify(
        mockJsonFileManager.copyAssetToLocal(
          principalAssetPath,
          principalFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          validacaoAssetPath,
          validacaoFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          reavaliacaoAssetPath,
          reavaliacaoFileName,
        ),
      ).called(1);
    });

    test('should copy assets if files exist but are empty', () async {
      // Simula que os arquivos existem mas estão vazios
      when(mockJsonFileManager.fileExists(any)).thenAnswer((_) async => true);
      when(
        mockJsonFileManager.readJson(any),
      ).thenAnswer((_) async => {}); // Retorna mapa vazio

      when(
        mockJsonFileManager.copyAssetToLocal(any, any),
      ).thenAnswer((_) async => null);

      await dataInitializer.ensureLocalFilesExist();

      // Verifica se fileExists foi chamado para todos os arquivos (retornando true)
      verify(mockJsonFileManager.fileExists(principalFileName)).called(1);
      verify(mockJsonFileManager.fileExists(validacaoFileName)).called(1);
      verify(mockJsonFileManager.fileExists(reavaliacaoFileName)).called(1);

      // Verifica se readJson foi chamado para todos os arquivos (retornando mapa vazio)
      verify(mockJsonFileManager.readJson(principalFileName)).called(1);
      verify(mockJsonFileManager.readJson(validacaoFileName)).called(1);
      verify(mockJsonFileManager.readJson(reavaliacaoFileName)).called(1);

      // Verifica se copyAssetToLocal foi chamado para todos os arquivos (pois estavam vazios)
      verify(
        mockJsonFileManager.copyAssetToLocal(
          principalAssetPath,
          principalFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          validacaoAssetPath,
          validacaoFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          reavaliacaoAssetPath,
          reavaliacaoFileName,
        ),
      ).called(1);
    });

    test('should not copy assets if files exist and are not empty', () async {
      // Simula que os arquivos existem e têm conteúdo
      when(mockJsonFileManager.fileExists(any)).thenAnswer((_) async => true);
      when(mockJsonFileManager.readJson(any)).thenAnswer(
        (_) async => {'data': 'some_content'},
      ); // Retorna mapa não vazio

      await dataInitializer.ensureLocalFilesExist();

      // Verifica se fileExists foi chamado para todos os arquivos
      verify(mockJsonFileManager.fileExists(principalFileName)).called(1);
      verify(mockJsonFileManager.fileExists(validacaoFileName)).called(1);
      verify(mockJsonFileManager.fileExists(reavaliacaoFileName)).called(1);

      // Verifica se readJson foi chamado para todos os arquivos
      verify(mockJsonFileManager.readJson(principalFileName)).called(1);
      verify(mockJsonFileManager.readJson(validacaoFileName)).called(1);
      verify(mockJsonFileManager.readJson(reavaliacaoFileName)).called(1);

      // Verifica que copyAssetToLocal NUNCA foi chamado
      verifyNever(mockJsonFileManager.copyAssetToLocal(any, any));
    });

    test('should handle copyAssetToLocal errors gracefully', () async {
      // Simula que os arquivos não existem
      when(mockJsonFileManager.fileExists(any)).thenAnswer((_) async => false);
      when(mockJsonFileManager.readJson(any)).thenAnswer((_) async => {});

      // Simula um erro ao copiar um asset (por exemplo, o principal.json)
      when(
        mockJsonFileManager.copyAssetToLocal(
          principalAssetPath,
          principalFileName,
        ),
      ).thenThrow(Exception('Failed to copy principal.json'));

      // Os outros assets ainda devem ser copiados
      when(
        mockJsonFileManager.copyAssetToLocal(
          validacaoAssetPath,
          validacaoFileName,
        ),
      ).thenAnswer((_) async => null);
      when(
        mockJsonFileManager.copyAssetToLocal(
          reavaliacaoAssetPath,
          reavaliacaoFileName,
        ),
      ).thenAnswer((_) async => null);

      await dataInitializer.ensureLocalFilesExist();

      // Verifica que o método de cópia foi tentado para todos (mesmo com erro em um)
      verify(
        mockJsonFileManager.copyAssetToLocal(
          principalAssetPath,
          principalFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          validacaoAssetPath,
          validacaoFileName,
        ),
      ).called(1);
      verify(
        mockJsonFileManager.copyAssetToLocal(
          reavaliacaoAssetPath,
          reavaliacaoFileName,
        ),
      ).called(1);

      // Em um cenário real com um logger, você verificaria se a mensagem de erro foi logada.
      // Com 'print', é mais difícil verificar diretamente no teste, mas a exceção foi capturada.
    });
  });
}
