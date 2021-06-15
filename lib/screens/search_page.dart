import 'dart:io';
import 'package:downloader/design.dart';
import 'package:downloader/screens/reels_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloader/utils/methods.dart';

TextEditingController _inputSearch = TextEditingController();

class SearchPage extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

String usernameState, followerState, followingState, imageUrlState;

class _SeaState extends State<SearchPage> {
  int progress = 0;
  String message = "";
  String path = "";
  String size = "";
  String mimeType = "";
  File imageFile;
  String _setDownloadText = "Download Profil Picture [HD]";
  Color setDownloadColor = orange;
  bool downloading = false;
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();

    _inputSearch.clear();
    _isButtonDisabled = false;
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        progress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/background.png"),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Downloader\n",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 110.0,
            left: 20.0,
            right: 20.0,
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(
                FontAwesomeIcons.user,
                size: 19,
                color: pink,
              ),
              primary: false,
              title: TextField(
                  onChanged: (value) {
                    setState(() {
                      _setDownloadText = "Download Profil Picture [HD]";
                      setDownloadColor = pink;
                      _isButtonDisabled = false;
                    });
                  },
                  controller: _inputSearch,
                  decoration: InputDecoration(
                      hintText: "Enter username",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: pink),
                  onPressed: () async {
                    FocusScope.of(context).nextFocus();
                    instagramuser = _inputSearch.text.toString();

                    print("Seacrh " + instagramuser);
                    await flutterInsta.getProfileData(instagramuser);
                    setState(() {
                      _isButtonDisabled = false;
                      usernameState = flutterInsta.username;
                      followerState = flutterInsta.followers;
                      followingState = flutterInsta.following;
                      imageUrlState = flutterInsta.imgurl;
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 250.0,
            left: 20.0,
            right: 20.0,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1.2,
                      blurRadius: 1.5,
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width / 1.2,
                height: flutterInsta.username != null
                    ? MediaQuery.of(context).size.height / 2.4
                    : MediaQuery.of(context).size.height / 2.6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                  child: flutterInsta.username != null
                      ? ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(flutterInsta.imgurl),
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                ),
                                Container(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${flutterInsta.username}" +
                                        "\n" +
                                        "${flutterInsta.followers} Followers | ${flutterInsta.following} Following"),
                                  ],
                                ),
                              ],
                            ),
                            Container(height: 20),
                            ListTile(
                              leading: new Icon(FontAwesomeIcons.info,
                                  color: pink, size: 17),
                              title: Text(
                                "About",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                              subtitle: new Text(
                                "${flutterInsta.bio}",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                            Container(height: 15),
                            ElevatedButton.icon(
                              icon: Icon(Icons.download_rounded,
                                  color: Colors.white),
                              style: raisedButtonStyle,
                              label: Text(
                                "$_setDownloadText",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () async {
                                      var status =
                                          await Permission.storage.status;
                                      if (status.isUndetermined) {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                        ].request();
                                        print(statuses[Permission.storage]);
                                      } else {
                                        downloadUserProfile(imageUrlState);

                                        setState(() {
                                          _isButtonDisabled = true;
                                          downloading = true;
                                          setDownloadColor = Colors.grey;
                                          _setDownloadText = "Downloaded";
                                        });
                                      }
                                    },
                            ),
                          ],
                        )
                      : ListView(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/icon2.png"),
                                  radius: 30,
                                ),
                                Container(width: 15),
                                Column(
                                  children: [
                                    Text(
                                      "User Name\n" +
                                          "0 Followers | 0 Following",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ListTile(
                              leading: new Icon(FontAwesomeIcons.info,
                                  color: pink, size: 17),
                              title: Text("Bio"),
                              subtitle: new Text(
                                "Welcome to Downloader!",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                            ListTile(
                              subtitle: Text(
                                  "If you are having a problem with the query, turn off the wifi network and activate the mobile data."),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String taskId;
  void downloadUserProfile(imageUrlState) async {
    taskId = await FlutterDownloader.enqueue(
      url: imageUrlState,
      savedDir: '/sdcard/Download',
      showNotification: true,
      openFileFromNotification: true,
      fileName: "instadownloader_$usernameState.jpg",
    ).whenComplete(() {
      setState(() {
        print("Downloaded");
        downloading = false;
      });
    });
  }
}
