import 'package:equatable/equatable.dart';

class AnimeQuoteEntity extends Equatable {
  final String anime;
  final String character;
  final String quote;

  const AnimeQuoteEntity({
    required this.anime,
    required this.character,
    required this.quote,
  });

  @override
  List<Object> get props => [anime, character, quote];
}
