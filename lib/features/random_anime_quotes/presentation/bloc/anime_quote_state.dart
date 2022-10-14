part of 'anime_quote_bloc.dart';

abstract class AnimeQuoteState extends Equatable {
  const AnimeQuoteState();

  @override
  List<Object> get props => [];
}

class AnimeQuoteEmptyState extends AnimeQuoteState {}

class AnimeQuoteLoadingState extends AnimeQuoteState {}

class AnimeQuoteLoadedState extends AnimeQuoteState {
  final AnimeQuoteEntity animeQuote;

  const AnimeQuoteLoadedState({
    required this.animeQuote,
  });
}

class AnimeQuoteErrorState extends AnimeQuoteState {
  final String errorMessage;

  const AnimeQuoteErrorState({
    required this.errorMessage,
  });
}
