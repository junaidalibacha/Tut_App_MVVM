import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnect;
}

class NetworkInfoImplementor implements NetworkInfo {
  final InternetConnectionChecker _dataConnectionChecker;
  NetworkInfoImplementor(this._dataConnectionChecker);
  @override
  Future<bool> get isConnect => _dataConnectionChecker.hasConnection;
}
