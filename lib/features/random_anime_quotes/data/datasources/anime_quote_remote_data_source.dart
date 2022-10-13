import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/anime_quote_model.dart';
import '../../../../constants/constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class AnimeQuoteRemoteDataSource {
  Future<AnimeQuoteModel> getRandomAnimeQuote();
}

class AnimeQuoteRemoteDataSourceImplementation
    extends AnimeQuoteRemoteDataSource {
  final http.Client client;

  AnimeQuoteRemoteDataSourceImplementation({
    required this.client,
  });

  @override
  Future<AnimeQuoteModel> getRandomAnimeQuote() async {
    final uri = Uri.parse(ANIME_CHAN_API);

    final headers = {
      "Content-Type": "application/json",
    };

    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final animeQuote = AnimeQuoteModel.fromJson(jsonResponse);

      return animeQuote;
    } else {
      throw ServerException();
    }
  }
}
