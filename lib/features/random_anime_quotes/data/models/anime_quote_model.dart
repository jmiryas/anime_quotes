import '../../domain/entities/anime_quote_entity.dart';

class AnimeQuoteModel extends AnimeQuoteEntity {
  const AnimeQuoteModel({
    required super.anime,
    required super.character,
    required super.quote,
  });

  factory AnimeQuoteModel.fromJson(Map<String, dynamic> json) {
    return AnimeQuoteModel(
      anime: json["anime"],
      character: json["character"],
      quote: json["quote"],
    );
  }

  Map<String, dynamic> toJson() => {
        "anime": anime,
        "character": character,
        "quote": quote,
      };
}
