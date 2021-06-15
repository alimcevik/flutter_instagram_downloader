import 'package:flutter_insta/flutter_insta.dart';
import 'package:url_launcher/url_launcher.dart';

String instagramuser;
FlutterInsta flutterInsta = new FlutterInsta();

goToWebSite(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

sendEMail() async {
  var url = 'mailto:' +
      'info@yazilimkaravani.net' +
      '?subject=SUPPORT | Downloader&body=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
