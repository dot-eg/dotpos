import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineService {
    Future<bool> isConnected() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    }

  Stream<bool> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> checkConnection() async {
    if (!await isConnected()) {
      throw Exception('No internet connection');
    }
  }

  
}