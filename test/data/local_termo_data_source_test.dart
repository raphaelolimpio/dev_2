/* // test/data/local_termo_data_source_test.dart

import 'package:dev/core/json_file_mananger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dev/data/local_termo_data_source.dart';
import 'package:dev/models/termo.dart';

// Gerar o mock para JsonFileManager
// Execute "flutter pub run build_runner build" no terminal para gerar o mock
@GenerateMocks([JsonFileManager])
import 'local_termo_data_source_test.mocks.dart'; // Arquivo gerado automaticamente

void main() {
  late LocalTermoDataSource dataSource;
  late MockJsonFileManager mockJsonFileManager;
  final testFileName = 'test_data.json';

  setUp(() {
    mockJsonFileManager = MockJsonFileManager();
    // Injeta o mock do JsonFileManager no LocalTermoDataSource
    dataSource = LocalTermoDataSource(
      testFileName,
      mockJsonFileManager,
    ); // Corrigido aqui
  });

  group('LocalTermoDataSource', () {
    // Dados de teste para simular o conteúdo do JSON
    // ATENÇÃO: TODOS OS MAPAS ABAIXO FORAM ATUALIZADOS PARA INCLUIR CAMPOS NULLABLES COM VALOR null
    final Map<String, dynamic> rawJsonData = {
      'Programação': [
        {
          'nome': 'Dart',
          'categoria': 'Linguagem',
          'definicao': 'Definicao Dart',
          'tema': 'Programação',
          'comando_exemplo': null,
          'explicacao_pratica': null,
          'dicas_de_uso': null,
        },
        {
          'nome': 'Flutter',
          'categoria': 'Framework',
          'definicao': 'Definicao Flutter',
          'tema': 'Programação',
          'comando_exemplo': null,
          'explicacao_pratica': null,
          'dicas_de_uso': null,
        },
      ],
      'Redes': [
        {
          'nome': 'HTTP',
          'categoria': 'Protocolo',
          'definicao': 'Definicao HTTP',
          'tema': 'Redes',
          'comando_exemplo': null,
          'explicacao_pratica': null,
          'dicas_de_uso': null,
        },
      ],
    };

    final Map<String, List<Termo>> parsedTermos = {
      'Programação': [
        Termo(
          nome: 'Dart',
          categoria: 'Linguagem',
          definicao: 'Definicao Dart',
          tema: 'Programação',
        ),
        Termo(
          nome: 'Flutter',
          categoria: 'Framework',
          definicao: 'Definicao Flutter',
          tema: 'Programação',
        ),
      ],
      'Redes': [
        Termo(
          nome: 'HTTP',
          categoria: 'Protocolo',
          definicao: 'Definicao HTTP',
          tema: 'Redes',
        ),
      ],
    };

    // --- TESTES DE LEITURA ---
    test('findAll should return all terms parsed correctly', () async {
      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => rawJsonData);

      final result = await dataSource.findAll();

      expect(result, isA<Map<String, List<Termo>>>());
      expect(result.length, 2); // 'Programação', 'Redes'
      expect(result['Programação']!.length, 2);
      expect(result['Redes']!.length, 1);
      expect(result['Programação']![0].nome, 'Dart');
      expect(result['Redes']![0].nome, 'HTTP');
      verify(mockJsonFileManager.readJson(testFileName)).called(1);
    });

    test('findByTemaAndNome should find an existing termo', () async {
      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => rawJsonData);

      final termo = await dataSource.findByTemaAndNome(
        'Programação',
        'Flutter',
      );

      expect(termo, isNotNull);
      expect(termo!.nome, 'Flutter');
      expect(termo.tema, 'Programação');
      verify(mockJsonFileManager.readJson(testFileName)).called(1);
    });

    test('findByTemaAndNome should return null if termo not found', () async {
      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => rawJsonData);

      final termo = await dataSource.findByTemaAndNome('Programação', 'Python');

      expect(termo, isNull);
      verify(mockJsonFileManager.readJson(testFileName)).called(1);
    });

    test('listThemes should return all unique themes', () async {
      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => rawJsonData);

      final themes = await dataSource.listThemes();

      expect(themes, ['Programação', 'Redes']);
      verify(mockJsonFileManager.readJson(testFileName)).called(1);
    });

    test('listAllTermosFlat should return all termos in a flat list', () async {
      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => rawJsonData);

      final termos = await dataSource.listAllTermosFlat();

      expect(termos.length, 3);
      expect(
        termos,
        contains(
          Termo(
            nome: 'Dart',
            categoria: 'Linguagem',
            definicao: 'Definicao Dart',
            tema: 'Programação',
          ),
        ),
      );
      expect(
        termos,
        contains(
          Termo(
            nome: 'HTTP',
            categoria: 'Protocolo',
            definicao: 'Definicao HTTP',
            tema: 'Redes',
          ),
        ),
      );
      verify(mockJsonFileManager.readJson(testFileName)).called(1);
    });

    // --- TESTES DE ESCRITA (SAVE) ---
    test('save should add a new termo if not exists', () async {
      final existingRawData = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };
      final newTermo = Termo(
        nome: 'Python',
        categoria: 'Linguagem',
        definicao: 'Definicao Python',
        tema: 'Programação',
      );
      final expectedRawDataAfterAdd = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
          {
            'nome': 'Python',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Python',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };

      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => existingRawData);
      when(
        mockJsonFileManager.writeJson(testFileName, any),
      ) // 'any' para capturar o que for passado
      .thenAnswer((_) async => {});

      final success = await dataSource.save('Programação', newTermo);

      expect(success, isTrue);
      // Verifica se o writeJson foi chamado com os dados atualizados
      verify(
        mockJsonFileManager.writeJson(
          testFileName,
          argThat(equals(expectedRawDataAfterAdd)),
        ),
      ).called(1);
    });

    test('save should update an existing termo', () async {
      final existingRawData = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
          {
            'nome': 'Flutter',
            'categoria': 'Framework',
            'definicao': 'Definicao Flutter',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };
      final updatedTermo = Termo(
        nome: 'Flutter',
        categoria: 'UI Framework',
        definicao: 'Flutter atualizado.',
        tema: 'Programação',
      );
      final expectedRawDataAfterUpdate = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
          {
            'nome': 'Flutter',
            'categoria': 'UI Framework',
            'definicao': 'Flutter atualizado.',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };

      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => existingRawData);
      when(
        mockJsonFileManager.writeJson(testFileName, any),
      ).thenAnswer((_) async => {});

      final success = await dataSource.save('Programação', updatedTermo);

      expect(success, isTrue);
      verify(
        mockJsonFileManager.writeJson(
          testFileName,
          argThat(equals(expectedRawDataAfterUpdate)),
        ),
      ).called(1);
    });

    test('save should create a new theme if not exists', () async {
      final existingRawData = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };
      final newTermo = Termo(
        nome: 'TermoNovo',
        categoria: 'NovaCat',
        definicao: 'Nova Def.',
        tema: 'NovoTema',
      );
      final expectedRawDataAfterNewTheme = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
        'NovoTema': [
          {
            'nome': 'TermoNovo',
            'categoria': 'NovaCat',
            'definicao': 'Nova Def.',
            'tema': 'NovoTema',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };

      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => existingRawData);
      when(
        mockJsonFileManager.writeJson(testFileName, any),
      ).thenAnswer((_) async => {});

      final success = await dataSource.save('NovoTema', newTermo);

      expect(success, isTrue);
      verify(
        mockJsonFileManager.writeJson(
          testFileName,
          argThat(equals(expectedRawDataAfterNewTheme)),
        ),
      ).called(1);
    });

    // --- TESTES DE EXCLUSÃO (DELETE) ---
    test('deleteByTemaAndNome should remove an existing termo', () async {
      final existingRawData = {
        'Programação': [
          {
            'nome': 'Dart',
            'categoria': 'Linguagem',
            'definicao': 'Definicao Dart',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
          {
            'nome': 'Flutter',
            'categoria': 'Framework',
            'definicao': 'Definicao Flutter',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };
      final expectedRawDataAfterDelete = {
        'Programação': [
          {
            'nome': 'Flutter',
            'categoria': 'Framework',
            'definicao': 'Definicao Flutter',
            'tema': 'Programação',
            'comando_exemplo': null,
            'explicacao_pratica': null,
            'dicas_de_uso': null,
          },
        ],
      };

      when(
        mockJsonFileManager.readJson(testFileName),
      ).thenAnswer((_) async => existingRawData);
      when(
        mockJsonFileManager.writeJson(testFileName, any),
      ).thenAnswer((_) async => {});

      final success = await dataSource.deleteByTemaAndNome(
        'Programação',
        'Dart',
      );

      expect(success, isTrue);
      verify(
        mockJsonFileManager.writeJson(
          testFileName,
          argThat(equals(expectedRawDataAfterDelete)),
        ),
      ).called(1);
    });

    test(
      'deleteByTemaAndNome should remove theme if last termo is deleted',
      () async {
        final existingRawData = {
          'Redes': [
            {
              'nome': 'HTTP',
              'categoria': 'Protocolo',
              'definicao': 'Definicao HTTP',
              'tema': 'Redes',
              'comando_exemplo': null,
              'explicacao_pratica': null,
              'dicas_de_uso': null,
            },
          ],
        };
        final expectedRawDataAfterDelete = {}; // Tema 'Redes' deve ser removido

        when(
          mockJsonFileManager.readJson(testFileName),
        ).thenAnswer((_) async => existingRawData);
        when(
          mockJsonFileManager.writeJson(testFileName, any),
        ).thenAnswer((_) async => {});

        final success = await dataSource.deleteByTemaAndNome('Redes', 'HTTP');

        expect(success, isTrue);
        verify(
          mockJsonFileManager.writeJson(
            testFileName,
            argThat(equals(expectedRawDataAfterDelete)),
          ),
        ).called(1);
      },
    );

    test(
      'deleteByTemaAndNome should return false if termo or theme not found',
      () async {
        when(
          mockJsonFileManager.readJson(testFileName),
        ).thenAnswer((_) async => rawJsonData);
        when(
          mockJsonFileManager.writeJson(testFileName, any),
        ).thenAnswer((_) async => {}); // Não deve ser chamado

        // Termo não existe
        final success1 = await dataSource.deleteByTemaAndNome(
          'Programação',
          'Python',
        );
        expect(success1, isFalse);
        verifyNever(
          mockJsonFileManager.writeJson(testFileName, any),
        ); // Verifica que não chamou writeJson

        // Tema não existe
        final success2 = await dataSource.deleteByTemaAndNome(
          'TemaInexistente',
          'QualquerTermo',
        );
        expect(success2, isFalse);
        verifyNever(
          mockJsonFileManager.writeJson(testFileName, any),
        ); // Verifica que não chamou writeJson
      },
    );
  });
}
// Função auxiliar para converter o JSON em uma lista de Termos */
