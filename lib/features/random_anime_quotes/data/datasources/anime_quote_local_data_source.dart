import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/anime_quote_model.dart';
import '../../../../constants/constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class AnimeQuoteLocalDataSource {
  Future<AnimeQuoteModel> getLastAnimeQuote();
  Future<void> cacheAnimeQuote(AnimeQuoteModel animeQuote);
}

class AnimeQuoteLocalDataSourceImplementation
    extends AnimeQuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  AnimeQuoteLocalDataSourceImplementation({
    required this.sharedPreferences,
  });

  @override
  Future<AnimeQuoteModel> getLastAnimeQuote() {
    final animeQuoteJson = sharedPreferences.getString(CACHED_ANIME_QUOTE);

    return animeQuoteJson == null
        ? throw CacheException()
        : Future.value(
            AnimeQuoteModel.fromJson(
              json.decode(animeQuoteJson),
            ),
          );
  }

  @override
  Future<void> cacheAnimeQuote(AnimeQuoteModel animeQuote) async {
    final animeQuoteString = json.encode(animeQuote.toJson());

    sharedPreferences.setString(CACHED_ANIME_QUOTE, animeQuoteString);
  }
}
