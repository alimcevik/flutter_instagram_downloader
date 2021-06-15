import 'package:downloader/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:downloader/widgets/navbar_widget.dart';
import 'package:flutter/services.dart';

final Shader linearGradient = LinearGradient(colors: <Color>[orange, pink])
    .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 2800)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icon2.png",
              scale: 3,
            ),
            Text("Downloader",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                )),
            SizedBox(
              height: 20,
            ),
            Text("Download Posts, Reels and Profile Pictures",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
