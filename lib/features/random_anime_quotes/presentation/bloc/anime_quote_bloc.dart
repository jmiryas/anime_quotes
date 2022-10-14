import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../constants/constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/anime_quote_entity.dart';
import '../../domain/usecases/get_random_anime_quotes.dart';

part 'anime_quote_event.dart';
part 'anime_quote_state.dart';

class AnimeQuoteBloc extends Bloc<AnimeQuoteEvent, AnimeQuoteState> {
  final GetRandomAnimeQuotes getRandomAnimeQuotes;

  AnimeQuoteBloc({
    required this.getRandomAnimeQuotes,
  }) : super(AnimeQuoteEmptyState()) {
    on<GetRandomAnimeQuotesEvent>(_getRandomAnimeQuotesEventHandler);
  }

  Future<void> _getRandomAnimeQuotesEventHandler(
      GetRandomAnimeQuotesEvent event, Emitter<AnimeQuoteState> emit) async {
    emit(AnimeQuoteLoadingState());

    final either = await getRandomAnimeQuotes(NoParams());

    _emitAnimeQuoteResult(either, emit);
  }

  String _mapFailureToMessage(Failure failure) {
    String message = "Unexpected error";

    switch (failure.runtimeType) {
      case ServerFailure:
        message = SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        message = CACHE_FAILURE_MESSAGE;
        break;
      default:
        message = "Unexpected error";
        break;
    }

    return message;
  }

  void _emitAnimeQuoteResult(
    Either<Failure, AnimeQuoteEntity> either,
    Emitter<AnimeQuoteState> emit,
  ) async {
    await either.fold(
      (failure) async => emit(
        AnimeQuoteErrorState(
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (animeQuote) async => emit(AnimeQuoteLoadedState(animeQuote: animeQuote)),
    );
  }
}
