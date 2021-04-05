import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color mor = Color(0xffB63D99);
String socialLink;
Widget appbar() {
  return AppBar(
    title: Text("Insta Downloader"),
    elevation: 0,
    backgroundColor: mor,
    centerTitle: true,
    /* bottom: PreferredSize(
      preferredSize: Size(double.infinity, 20),
      child: Container(
        child: Image.asset("assets/appbar.png"),
      ),
    ),*/
  );
}
