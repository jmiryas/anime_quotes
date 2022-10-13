import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/anime_quote_entity.dart';
import '../datasources/anime_quote_local_data_source.dart';
import '../datasources/anime_quote_remote_data_source.dart';
import '../../domain/repositories/random_anime_quotes_repository.dart';

class RandomAnimeQuotesRepositoryImplementation
    extends RandomAnimeQuotesRepository {
  final AnimeQuoteLocalDataSource animeQuoteLocalDataSource;
  final AnimeQuoteRemoteDataSource animeQuoteRemoteDataSource;
  final NetworkInfo networkInfo;

  RandomAnimeQuotesRepositoryImplementation({
    required this.animeQuoteLocalDataSource,
    required this.animeQuoteRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AnimeQuoteEntity>> getRandomAnimeQuotes() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final animeQuote =
            await animeQuoteRemoteDataSource.getRandomAnimeQuote();

        animeQuoteLocalDataSource.cacheAnimeQuote(animeQuote);

        return Right(animeQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final animeQuote = await animeQuoteLocalDataSource.getLastAnimeQuote();

        return Right(animeQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
