import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:profile_picture/screens/splash_page.dart';

void main() {
  runApp(MyApp());
  FlutterDownloader.initialize();
//  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-1214689406608334~2048198162");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.purple,
      title: 'Instagram Downloader',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: SplashPage(),
    );
  }
}
