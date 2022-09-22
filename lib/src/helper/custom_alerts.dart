import 'package:flutter/material.dart';

class CustomAlerts{

  static Future showAlertWithPositiveNegativeButton(BuildContext context, String message, String positiveButton, String negativeButton, Function positiveFunction, Function negativeFunction) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                negativeFunction();
              },
              child: Text(negativeButton,style: const TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () {
                positiveFunction();
              },
              child: Text(positiveButton,style: const TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

}

