import 'package:flutter/material.dart';

import 'service_locator.dart';
import 'features/random_anime_quotes/presentation/pages/anime_quote_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeServiceLocator().then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anime Quote",
      home: AnimeQuotePage(),
    );
  }
}
