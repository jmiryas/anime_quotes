import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anime_quotes/core/network/network_info.dart';
import 'package:anime_quotes/features/random_anime_quotes/data/datasources/anime_quote_local_data_source.dart';
import 'package:anime_quotes/features/random_anime_quotes/data/datasources/anime_quote_remote_data_source.dart';
import 'package:anime_quotes/features/random_anime_quotes/data/repositories/random_anime_quotes_repository_implementation.dart';
import 'package:anime_quotes/features/random_anime_quotes/data/models/anime_quote_model.dart';
import 'package:anime_quotes/features/random_anime_quotes/domain/entities/anime_quote_entity.dart';

class MockRemoteDataSource extends Mock implements AnimeQuoteRemoteDataSource {}

class MockLocalDataSource extends Mock implements AnimeQuoteLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late final MockRemoteDataSource mockRemoteDataSource;
  late final MockLocalDataSource mockLocalDataSource;
  late final MockNetworkInfo mockNetworkInfo;

  late final RandomAnimeQuotesRepositoryImplementation repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = RandomAnimeQuotesRepositoryImplementation(
      animeQuoteLocalDataSource: mockLocalDataSource,
      animeQuoteRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("getRandomAnimeQuotes", () {
    const testAnimeQuote = AnimeQuoteModel(
      anime: "Anime",
      character: "Caharacter",
      quote: "Quote",
    );

    test("seharusnya mengecek apakah device online", () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer(
        (_) async => true,
      );

      when(() => mockRemoteDataSource.getRandomAnimeQuote()).thenAnswer(
        (_) async => testAnimeQuote,
      );

      when(() => mockLocalDataSource.cacheAnimeQuote(testAnimeQuote))
          .thenAnswer(
        (_) async => Future<void>(() {}),
      );

      repository.getRandomAnimeQuotes();

      verify(() => mockNetworkInfo.isConnected);
    });
  });
}
