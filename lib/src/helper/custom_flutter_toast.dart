import 'package:fluttertoast/fluttertoast.dart';

class CustomFlutterToast{

  static void showToast(String message){
    Fluttertoast.showToast(msg: message);
  }

}