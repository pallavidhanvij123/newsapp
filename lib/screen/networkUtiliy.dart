import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtility {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
