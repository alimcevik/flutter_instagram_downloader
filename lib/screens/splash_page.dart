import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:profile_picture/widgets/navbar_widget.dart';
import 'package:flutter/services.dart';
import 'package:profile_picture/widgets/appbar_widget.dart';

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
            Lottie.asset(
              'assets/logo.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
              width: 175,
              reverse: false,
              animate: false,
              fit: BoxFit.fill,
            ),
            Text("Insta Downloader",
                style: TextStyle(
                    fontSize: 23, color: mor, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Text("Downloadable Reels & Profile Pictures",
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
