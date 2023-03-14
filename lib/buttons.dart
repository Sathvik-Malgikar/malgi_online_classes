import 'package:flutter/material.dart';
import "package:malgi_online_classes/main.dart";

logoutbtn(context) {
Widget btn = Padding(
          padding: EdgeInsets.all(20),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                RestartWidget.restartApp(context);
              },
              child: Text("LOGOUT")),
        );
  return btn;
}
