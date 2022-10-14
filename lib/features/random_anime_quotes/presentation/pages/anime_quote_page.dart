import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/anime_quote_bloc.dart';
import '../../../../service_locator.dart';
import '../widgets/anime_quote_card_widget.dart';
import '../widgets/anime_quote_button_widget.dart';

class AnimeQuotePage extends StatelessWidget {
  const AnimeQuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Anime Quote"),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator.get<AnimeQuoteBloc>(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<AnimeQuoteBloc, AnimeQuoteState>(
                  builder: (context, state) {
                late Widget widget;

                if (state is AnimeQuoteEmptyState) {
                  widget = const Center(
                    child: Text("Tekan tombol untuk menampilkan quote anime."),
                  );
                } else if (state is AnimeQuoteLoadingState) {
                  widget = const Center(
                    child: SizedBox(
                      width: 25.0,
                      height: 25.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is AnimeQuoteLoadedState) {
                  widget = AnimeQuoteCardWidget(animeQuote: state.animeQuote);
                } else if (state is AnimeQuoteErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }

                return widget;
              }),
              const SizedBox(
                height: 20.0,
              ),
              const AnimeQuoteButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
