import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anime_quotes/features/random_anime_quotes/domain/entities/anime_quote_entity.dart';
import 'package:anime_quotes/features/random_anime_quotes/domain/usecases/get_random_anime_quotes.dart';
import 'package:anime_quotes/features/random_anime_quotes/domain/repositories/random_anime_quotes_repository.dart';

class MockRandomAnimeQuotesRepository extends Mock
    implements RandomAnimeQuotesRepository {}

void main() {
  late final MockRandomAnimeQuotesRepository mockRandomAnimeQuotesRepository;
  late final GetRandomAnimeQuotes usecase;

  setUp(() {
    mockRandomAnimeQuotesRepository = MockRandomAnimeQuotesRepository();

    usecase = GetRandomAnimeQuotes(
      randomAnimeQuotesRepository: mockRandomAnimeQuotesRepository,
    );
  });

  const testAnimeQuote = AnimeQuoteEntity(
    anime: "Rokka no Yuusha",
    character: "Adlet Mayer",
    quote:
        "I was able to become strong because I still believe those words. That a man can't become strong for revenge's sake. He becomes strong because he believes in something.",
  );

  test(
    "seharusnya mengembalikan Anime Quote Entity dari repository",
    () async {
      when(() => mockRandomAnimeQuotesRepository.getRandomAnimeQuotes())
          .thenAnswer(
        (_) async => const Right(testAnimeQuote),
      );

      final result = await usecase(NoParams());

      expect(
        result,
        const Right(testAnimeQuote),
      );

      verify(() => mockRandomAnimeQuotesRepository.getRandomAnimeQuotes());

      verifyNoMoreInteractions(mockRandomAnimeQuotesRepository);
    },
  );
}
