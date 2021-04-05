import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../utils/methods.dart';
import '../widgets/appbar_widget.dart';

Widget about(BuildContext context) {
  return Scaffold(
    appBar: appbar(),
    body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/background.png"),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(children: <Widget>[
                Container(height: 20),
                Center(
                  child: Lottie.asset(
                    'assets/karavan.json',
                    width: 175,
                    reverse: false,
                    animate: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Center(child: Text("Yazılım Karavanı \u00a9  2021")),
                Container(height: 10),
                ListTile(
                  leading: Icon(FontAwesomeIcons.instagramSquare,
                      color: mor, size: 30),
                  title: Text(
                    "@yazilimkaravani",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800]),
                  ),
                  subtitle: Text("Follow us on Instagram"),
                  onTap: () {
                    socialLink = "https://instagram.com/yazilimkaravani";
                    siteyeGit(socialLink);
                  },
                ),
                Container(
                  height: 0.3,
                  color: Colors.grey[400],
                ),
                ListTile(
                  leading:
                      new Icon(FontAwesomeIcons.linkedin, color: mor, size: 30),
                  title: new Text(
                    "yazilimkaravani",
                    style: new TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  subtitle: Text("Contact us on LinkedIn"),
                  onTap: () {
                    socialLink = "http://linkedin.com/company/yazilim-karavani";
                    siteyeGit(socialLink);
                  },
                ),
                Container(
                  height: 0.3,
                  color: Colors.grey[400],
                ),
                ListTile(
                  leading:
                      new Icon(Icons.local_post_office, color: mor, size: 30),
                  title: new Text(
                    "info@yazilimkaravani.net",
                    style: new TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  subtitle: Text("Write us on e-mail"),
                  onTap: () {
                    Navigator.pushNamed(context, mailGonder());
                  },
                ),
                Container(
                  height: 0.3,
                  color: Colors.grey[400],
                ),
                ListTile(
                  leading:
                      new Icon(FontAwesomeIcons.globe, color: mor, size: 30),
                  title: new Text(
                    "www.yazilimkaravani.net",
                    style: new TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  subtitle: Text("Visit our blog!"),
                  onTap: () {
                    socialLink = "https://yazilimkaravani.net";
                    siteyeGit(socialLink);
                  },
                ),
              ]),
            ),
            alignment: Alignment.center,
          ),
        ),
      ),
    ),
  );
}
