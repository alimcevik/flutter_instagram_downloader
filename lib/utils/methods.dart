import 'package:flutter_insta/flutter_insta.dart';
import 'package:url_launcher/url_launcher.dart';

String instagramuser;
FlutterInsta flutterInsta = new FlutterInsta();

getPost(instagramuser) async {
  await flutterInsta.getProfileData("$instagramuser").then((value) => () {
        print("Username : ${flutterInsta.username}");
        print("Followers : ${flutterInsta.followers}");
        print("Folowing : ${flutterInsta.following}");
        print("Bio : ${flutterInsta.bio}");
        print("Website : ${flutterInsta.website}");
        print("Profile Image : ${flutterInsta.imgurl}");
        print("Feed images: ${flutterInsta.feedImagesUrl}");
      });
}

/*
void downloadReels() async {
  var s = await flutterInsta
      .downloadReels("https://www.instagram.com/p/CDlGkdZgB2y");
  print(s);
}
*/
siteyeGit(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

mailGonder() async {
  var url = 'mailto:' +
      'info@yazilimkaravani.net' +
      '?subject=SUPPORT | Insta Downloader&body=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
