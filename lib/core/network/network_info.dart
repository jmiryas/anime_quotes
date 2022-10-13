import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementation extends NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImplementation({
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
