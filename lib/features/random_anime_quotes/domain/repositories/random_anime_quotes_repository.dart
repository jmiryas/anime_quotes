import 'package:dartz/dartz.dart';

import '../entities/anime_quote_entity.dart';
import '../../../../core/error/failures.dart';

abstract class RandomAnimeQuotesRepository {
  Future<Either<Failure, AnimeQuoteEntity>> getRandomAnimeQuotes();
}
