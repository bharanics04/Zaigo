import 'package:connectivity_plus/connectivity_plus.dart';

class Utils{

  static bool isEmpty(String? data){
    return data==null || data.isEmpty;
  }

  static bool isNotEmpty(String? data){
    return data!=null && data.isNotEmpty;
  }

  static Future<bool> onCheckConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}