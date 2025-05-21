// test/services/principal_termo_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dev/models/termo.dart';
import 'package:dev/repositories/termo_repository.dart';
import 'package:dev/services/principal_termo_service.dart';

// Gerar o mock para o TermoRepository
@GenerateMocks([TermoRepository])
import 'principal_termo_service_test.mocks.dart'; // Arquivo mock que será gerado

void main() {
  late PrincipalTermoService service;
  late MockTermoRepository mockTermoRepository; // Use o mock gerado

  // Dados de exemplo para os testes
  final termoDart = Termo(
    nome: 'Dart',
    categoria: 'Linguagem',
    definicao: 'Linguagem de programação para Flutter.',
    tema: 'Programação',
    comandoExemplo: null,
    explicacaoPratica: null,
    dicasDeUso: null,
  );
  final termoFlutter = Termo(
    nome: 'Flutter',
    categoria: 'Framework',
    definicao: 'Framework de UI para mobile, web e desktop.',
    tema: 'Programação',
    comandoExemplo: null,
    explicacaoPratica: null,
    dicasDeUso: null,
  );
  final termoHTTP = Termo(
    nome: 'HTTP',
    categoria: 'Protocolo',
    definicao: 'Protocolo de Transferência de Hipertexto.',
    tema: 'Redes',
    comandoExemplo: null,
    explicacaoPratica: null,
    dicasDeUso: null,
  );

  final Map<String, List<Termo>> allTermosData = {
    'Programação': [termoDart, termoFlutter],
    'Redes': [termoHTTP],
  };

  final List<String> allThemes = ['Programação', 'Redes'];

  setUp(() {
    mockTermoRepository = MockTermoRepository();
    service = PrincipalTermoService(mockTermoRepository); // Injeta o mock
  });

  group('PrincipalTermoService', () {
    test(
      'buscarTermos should return all terms if no filters are applied',
      () async {
        when(
          mockTermoRepository.findAll(),
        ).thenAnswer((_) async => allTermosData);

        final result = await service.buscarTermos();

        expect(result.length, 3);
        expect(result, containsAll([termoDart, termoFlutter, termoHTTP]));
        verify(mockTermoRepository.findAll()).called(1);
      },
    );

    test('buscarTermos should filter by tema', () async {
      when(
        mockTermoRepository.findAll(),
      ).thenAnswer((_) async => allTermosData);

      final result = await service.buscarTermos(tema: 'Programação');

      expect(result.length, 2);
      expect(result, containsAll([termoDart, termoFlutter]));
      expect(result, isNot(contains(termoHTTP)));
      verify(mockTermoRepository.findAll()).called(1);
    });

    test('buscarTermos should filter by nome (contains)', () async {
      when(
        mockTermoRepository.findAll(),
      ).thenAnswer((_) async => allTermosData);

      final result = await service.buscarTermos(
        nome: 'Flu',
      ); // 'Flu' deve pegar Flutter

      expect(result.length, 1);
      expect(result, contains(termoFlutter));
      verify(mockTermoRepository.findAll()).called(1);
    });

    test('buscarTermos should filter by categoria', () async {
      when(
        mockTermoRepository.findAll(),
      ).thenAnswer((_) async => allTermosData);

      final result = await service.buscarTermos(categoria: 'Linguagem');

      expect(result.length, 1);
      expect(result, contains(termoDart));
      verify(mockTermoRepository.findAll()).called(1);
    });

    test('buscarTermos should combine multiple filters', () async {
      when(
        mockTermoRepository.findAll(),
      ).thenAnswer((_) async => allTermosData);

      final result = await service.buscarTermos(
        tema: 'Programação',
        nome: 'Dart',
      );

      expect(result.length, 1);
      expect(result, contains(termoDart));
      verify(mockTermoRepository.findAll()).called(1);
    });

    test('buscarTermos should return empty list if no matches', () async {
      when(
        mockTermoRepository.findAll(),
      ).thenAnswer((_) async => allTermosData);

      final result = await service.buscarTermos(tema: 'Inexistente');

      expect(result, isEmpty);
      verify(mockTermoRepository.findAll()).called(1);
    });

    test(
      'getTemas should call repository.listThemes and return themes',
      () async {
        when(
          mockTermoRepository.listThemes(),
        ).thenAnswer((_) async => allThemes);

        final result = await service.getTemas();

        expect(result, allThemes);
        verify(mockTermoRepository.listThemes()).called(1);
      },
    );

    test(
      'addOrUpdatePrincipalTermo should call repository.save and return success message',
      () async {
        when(mockTermoRepository.save(any, any)).thenAnswer((_) async => true);

        final message = await service.addOrUpdatePrincipalTermo(
          'Programação',
          termoDart,
        );

        expect(message, "Termo salvo no arquivo principal.");
        verify(mockTermoRepository.save('Programação', termoDart)).called(1);
      },
    );

    test(
      'addOrUpdatePrincipalTermo should call repository.save and return failure message',
      () async {
        when(mockTermoRepository.save(any, any)).thenAnswer((_) async => false);

        final message = await service.addOrUpdatePrincipalTermo(
          'Programação',
          termoDart,
        );

        expect(message, "Falha ao salvar termo no principal.");
        verify(mockTermoRepository.save('Programação', termoDart)).called(1);
      },
    );

    test(
      'removePrincipalTermo should call repository.deleteByTemaAndNome and return success message',
      () async {
        when(
          mockTermoRepository.deleteByTemaAndNome(any, any),
        ).thenAnswer((_) async => true);

        final message = await service.removePrincipalTermo(
          'Programação',
          'Dart',
        );

        expect(message, "Termo removido do arquivo principal.");
        verify(
          mockTermoRepository.deleteByTemaAndNome('Programação', 'Dart'),
        ).called(1);
      },
    );

    test(
      'removePrincipalTermo should call repository.deleteByTemaAndNome and return failure message',
      () async {
        when(
          mockTermoRepository.deleteByTemaAndNome(any, any),
        ).thenAnswer((_) async => false);

        final message = await service.removePrincipalTermo(
          'Programação',
          'Dart',
        );

        expect(message, "Falha ao remover termo do principal.");
        verify(
          mockTermoRepository.deleteByTemaAndNome('Programação', 'Dart'),
        ).called(1);
      },
    );
  });
}
