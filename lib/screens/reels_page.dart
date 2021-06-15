import 'package:downloader/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloader/utils/methods.dart';

TextEditingController inputReels = TextEditingController();

class ReelsPage extends StatefulWidget {
  @override
  _ReelsState createState() => _ReelsState();
}

String usernameState, followerState, followingState, imageUrlState;
bool _isButtonDisabled;

Color _setDownloadColor = orange;
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: _setDownloadColor,
  primary: _setDownloadColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class _ReelsState extends State<ReelsPage> {
  int progress = 0;
  String _setDownloadReelsText = "Download";
  bool downloading = false;
  String reelsLink;

  @override
  void initState() {
    super.initState();
    inputReels.clear();
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
                style: TextStyle(fontSize: 19.0, color: Colors.white),
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
                      reelsLink = null;
                    });
                  },
                  controller: inputReels,
                  decoration: InputDecoration(
                      hintText: "Paste URL",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: pink),
                  onPressed: () async {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      _isButtonDisabled = false;
                      reelsLink = inputReels.text;
                      print("setState reelsLink: " + reelsLink);
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
                height: reelsLink == null
                    ? MediaQuery.of(context).size.height / 4.5
                    : MediaQuery.of(context).size.height / 3.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 15, 1),
                  child: reelsLink == null
                      ? ListView(
                          children: [
                            ListTile(
                              leading: new Icon(FontAwesomeIcons.info,
                                  color: pink, size: 17),
                              title: Text("Reels and Post Downloader"),
                              subtitle: new Text(
                                "You can download Instagram reels videos, photos and videos with this page.",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        )
                      : ListView(
                          children: [
                            ListTile(
                              leading: new Icon(FontAwesomeIcons.info,
                                  color: pink, size: 17),
                              title: Text("Ready!"),
                              subtitle: new Text(
                                "Your reels is ready.",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                            Container(height: 15),
                            ElevatedButton.icon(
                              style: raisedButtonStyle,
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
                                        downloadReels();
                                        setState(
                                          () {
                                            _isButtonDisabled = true;
                                            downloading = true;
                                          },
                                        );
                                      }
                                    },
                              icon: Icon(Icons.download_rounded,
                                  color: Colors.white),
                              label: Text(
                                "$_setDownloadReelsText",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
  void downloadReels() async {
    print("Reels link: " + reelsLink);
    var reelsDownloadLink = await flutterInsta.downloadReels(reelsLink);
    print("reelsDownloadLink: " + reelsDownloadLink);

    taskId = await FlutterDownloader.enqueue(
      url: reelsDownloadLink,
      savedDir: '/sdcard/Download',
      showNotification: true,
      fileName: "instagramdownloader_reels.mp4",
      openFileFromNotification: true,
    ).whenComplete(
      () {
        setState(
          () {
            print("Downloaded");
            downloading = false;
          },
        );
      },
    );
  }
}
