import 'package:flutter/material.dart';

import '../../domain/entities/anime_quote_entity.dart';

class AnimeQuoteCardWidget extends StatelessWidget {
  final AnimeQuoteEntity animeQuote;

  const AnimeQuoteCardWidget({
    super.key,
    required this.animeQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(animeQuote.anime),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(animeQuote.quote),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "- ${animeQuote.character}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
