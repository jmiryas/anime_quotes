import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/anime_quote_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/random_anime_quotes_repository.dart';

class GetRandomAnimeQuotes extends UseCase<AnimeQuoteEntity, NoParams> {
  final RandomAnimeQuotesRepository randomAnimeQuotesRepository;

  GetRandomAnimeQuotes({
    required this.randomAnimeQuotesRepository,
  });

  @override
  Future<Either<Failure, AnimeQuoteEntity>> call(NoParams params) async {
    return await randomAnimeQuotesRepository.getRandomAnimeQuotes();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
