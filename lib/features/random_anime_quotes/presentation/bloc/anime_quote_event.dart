part of 'anime_quote_bloc.dart';

abstract class AnimeQuoteEvent extends Equatable {
  const AnimeQuoteEvent();

  @override
  List<Object> get props => [];
}

class GetRandomAnimeQuotesEvent extends AnimeQuoteEvent {}
