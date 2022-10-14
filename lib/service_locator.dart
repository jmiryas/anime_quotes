import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/random_anime_quotes/presentation/bloc/anime_quote_bloc.dart';
import 'features/random_anime_quotes/domain/usecases/get_random_anime_quotes.dart';
import 'features/random_anime_quotes/data/datasources/anime_quote_local_data_source.dart';
import 'features/random_anime_quotes/data/datasources/anime_quote_remote_data_source.dart';
import 'features/random_anime_quotes/data/repositories/random_anime_quotes_repository_implementation.dart';
import 'features/random_anime_quotes/domain/repositories/random_anime_quotes_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  serviceLocator.registerFactory(
    () => AnimeQuoteBloc(
      getRandomAnimeQuotes: serviceLocator(),
    ),
  );

  // Register getRandomAnimeQuotes yang diperlukan AnimeQuoteBloc.

  serviceLocator.registerLazySingleton(
    () => GetRandomAnimeQuotes(
      randomAnimeQuotesRepository: serviceLocator(),
    ),
  );

  // Register randomAnimeQuotesRepository yang diperlukan GetRandomAnimeQuotes.

  serviceLocator.registerLazySingleton<RandomAnimeQuotesRepository>(
    () => RandomAnimeQuotesRepositoryImplementation(
      animeQuoteLocalDataSource: serviceLocator(),
      animeQuoteRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Register local, remote dan network info yang diperlukan RandomAnimeQuotesRepositoryImplementation.

  serviceLocator.registerLazySingleton<AnimeQuoteLocalDataSource>(
    () => AnimeQuoteLocalDataSourceImplementation(
      sharedPreferences: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AnimeQuoteRemoteDataSource>(
    () => AnimeQuoteRemoteDataSourceImplementation(
      client: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      internetConnectionChecker: serviceLocator(),
    ),
  );

  // Register shared preferences, http.Client dan network info untuk local, remote dan network info.

  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
