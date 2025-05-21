// test/repositories/termo_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dev/models/termo.dart';
import 'package:dev/core/termo_data_source.dart'; // Importa a interface TermoDataSource
import 'package:dev/repositories/termo_repository.dart'; // Importa a classe TermoRepository

// Gerar o mock para a interface TermoDataSource
// Certifique-se que o TermoDataSource está importado corretamente
@GenerateMocks([TermoDataSource])
import 'termo_repository_test.mocks.dart'; // Arquivo mock que será gerado

void main() {
  late TermoRepository termoRepository;
  late MockTermoDataSource mockTermoDataSource; // Use o mock gerado

  // Dados de exemplo para os testes
  final testTermo = Termo(
    nome: 'Dart',
    categoria: 'Linguagem',
    definicao: 'Linguagem de programação para Flutter.',
    tema: 'Programação',
  );
  final testTermoList = [testTermo];
  final testTermosMap = {'Programação': testTermoList};
  final testThemesList = ['Programação', 'Redes'];

  setUp(() {
    mockTermoDataSource = MockTermoDataSource();
    termoRepository = TermoRepository(mockTermoDataSource); // Injeta o mock
  });

  group('TermoRepository', () {
    test('findAll should call dataSource.findAll and return data', () async {
      // Configura o mock para retornar dados quando findAll for chamado
      when(
        mockTermoDataSource.findAll(),
      ).thenAnswer((_) async => testTermosMap);

      final result = await termoRepository.findAll();

      // Verifica se o método findAll do mock foi chamado
      verify(mockTermoDataSource.findAll()).called(1);
      // Verifica se o resultado é o esperado
      expect(result, testTermosMap);
    });

    test(
      'findByTemaAndNome should call dataSource.findByTemaAndNome and return data',
      () async {
        // Configura o mock
        when(
          mockTermoDataSource.findByTemaAndNome(any, any),
        ).thenAnswer((_) async => testTermo);

        final result = await termoRepository.findByTemaAndNome(
          'Programação',
          'Dart',
        );

        // Verifica se o método do mock foi chamado com os argumentos corretos
        verify(
          mockTermoDataSource.findByTemaAndNome('Programação', 'Dart'),
        ).called(1);
        expect(result, testTermo);
      },
    );

    test('save should call dataSource.save', () async {
      // Configura o mock
      when(mockTermoDataSource.save(any, any)).thenAnswer((_) async => true);

      final result = await termoRepository.save('Programação', testTermo);

      // Verifica se o método do mock foi chamado com os argumentos corretos
      verify(mockTermoDataSource.save('Programação', testTermo)).called(1);
      expect(result, isTrue);
    });

    test(
      'deleteByTemaAndNome should call dataSource.deleteByTemaAndNome',
      () async {
        // Configura o mock
        when(
          mockTermoDataSource.deleteByTemaAndNome(any, any),
        ).thenAnswer((_) async => true);

        final result = await termoRepository.deleteByTemaAndNome(
          'Programação',
          'Dart',
        );

        // Verifica se o método do mock foi chamado com os argumentos corretos
        verify(
          mockTermoDataSource.deleteByTemaAndNome('Programação', 'Dart'),
        ).called(1);
        expect(result, isTrue);
      },
    );

    test(
      'listThemes should call dataSource.listThemes and return data',
      () async {
        // Configura o mock
        when(
          mockTermoDataSource.listThemes(),
        ).thenAnswer((_) async => testThemesList);

        final result = await termoRepository.listThemes();

        // Verifica se o método do mock foi chamado
        verify(mockTermoDataSource.listThemes()).called(1);
        expect(result, testThemesList);
      },
    );

    test(
      'listAllTermosFlat should call dataSource.listAllTermosFlat and return data',
      () async {
        // Configura o mock
        when(
          mockTermoDataSource.listAllTermosFlat(),
        ).thenAnswer((_) async => testTermoList);

        final result = await termoRepository.listAllTermosFlat();

        // Verifica se o método do mock foi chamado
        verify(mockTermoDataSource.listAllTermosFlat()).called(1);
        expect(result, testTermoList);
      },
    );
  });
}
