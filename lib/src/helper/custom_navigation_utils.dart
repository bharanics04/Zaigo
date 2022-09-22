import 'package:flutter/material.dart';

class CustomNavigationUtils {
  static void pushReplacement(BuildContext context, dynamic data) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => data),
    );
  }

  static Future push(BuildContext context, dynamic data) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => data),
    );
  }

  static Future pushNamed(BuildContext context, dynamic data,{Object? arguments}) {
    return Navigator.pushNamed(
      context,
      data, arguments: arguments
    );
  }

  static Future pushReplacementNamed(BuildContext context, dynamic data,{Object? arguments}) {
    return Navigator.pushReplacementNamed(
        context,
        data, arguments: arguments
    );
  }

  static Future pushAndRemoveUntil(BuildContext context, dynamic data,) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => data),
        ModalRoute.withName("/Home"));
  }
}
