import 'package:downloader/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertExitDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text(
      "CANCEL",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "EXIT",
      style: TextStyle(color: pink, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      SystemNavigator.pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("Do you want exit to app?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
