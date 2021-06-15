import 'package:downloader/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String socialLink;
Widget appbar() {
  return AppBar(
    title: Text("Downloader"),
    elevation: 0,
    backgroundColor: pink,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              orange,
              pink,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),
  );
}
