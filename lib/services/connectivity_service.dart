import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:book_reading_app/services/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
  StreamController<ConnectivityStatus>();

  ConnectivityService() {

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {


      connectionStatusController.add(_getStatusFromResult(result));
    });
  }


  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
