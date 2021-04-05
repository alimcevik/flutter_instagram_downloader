import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_picture/widgets/appbar_widget.dart';

Widget exit(BuildContext context) {
  return Scaffold(
    appBar: appbar(),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/background.png"),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: Column(
        children: [
          Container(height: 220),
          Text("Do you want exit to app?",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              )),
          Container(height: 20),
          RaisedButton(
              color: mor,
              textColor: Colors.white,
              child: Text("Exit"),
              padding: EdgeInsets.all(12),
              onPressed: () {
                SystemNavigator.pop();
              })
        ],
      )),
    ),
  );
}
