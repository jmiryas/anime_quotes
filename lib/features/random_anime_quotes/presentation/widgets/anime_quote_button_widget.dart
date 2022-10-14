import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/anime_quote_bloc.dart';

class AnimeQuoteButtonWidget extends StatelessWidget {
  const AnimeQuoteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AnimeQuoteBloc>(context)
            .add(GetRandomAnimeQuotesEvent());
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50.0), // NEW
      ),
      child: const Text("Tampilkan Quote"),
    );
  }
}
