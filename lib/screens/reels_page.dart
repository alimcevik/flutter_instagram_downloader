import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_picture/utils/methods.dart';
import 'package:profile_picture/widgets/appbar_widget.dart';

TextEditingController inputReels = TextEditingController();

class ReelsPage extends StatefulWidget {
  @override
  _ReelsState createState() => _ReelsState();
}

String usernameState, followerState, followingState, imageUrlState;
bool _isButtonDisabled;

class _ReelsState extends State<ReelsPage> {
  int _progress = 0;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;
  String _setDownloadReelsText = "Download Reels";
  Color _setDownloadColor = mor;
  bool downloading = false;
  String reelsLink;

  @override
  void initState() {
    super.initState();
    inputReels.clear();
    _isButtonDisabled = false;

    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
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
              "Insta Downloader\n",
              style: TextStyle(fontSize: 19.0, color: Colors.white),
            ),
          ),
          color: mor,
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
              color: mor,
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
                    hintText: "Paste Reels URL",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: mor),
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
          top: 200.0,
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
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                //border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              height: reelsLink == null
                  ? MediaQuery.of(context).size.height / 4.5
                  : MediaQuery.of(context).size.height / 3.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 15, 1),
                child: reelsLink == null
                    //_inputReels.text == "" || _inputReels == null
                    ? ListView(
                        children: [
                          ListTile(
                            leading: new Icon(FontAwesomeIcons.info,
                                color: mor, size: 17),
                            title: Text("Reels Downloader"),
                            subtitle: new Text(
                              "You can download instagram reels videos with this page.",
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
                                color: mor, size: 17),
                            title: Text("Ready!"),
                            subtitle: new Text(
                              "Your reels is ready.",
                              style: new TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            ),
                          ),
                          Container(height: 15),
                          RaisedButton.icon(
                            onPressed: _isButtonDisabled
                                ? null
                                : () async {
                                    var status =
                                        await Permission.storage.status;
                                    if (status.isUndetermined) {
                                      // You can request multiple permissions at once.
                                      Map<Permission, PermissionStatus>
                                          statuses = await [
                                        Permission.storage,
                                        // Permission.camera,
                                      ].request();
                                      print(statuses[Permission.storage]);
                                    } else {
                                      print("izinler verilmiş..");

                                      download();

                                      setState(() {
                                        _isButtonDisabled = true;
                                        downloading = true;
                                        //   _setDownloadColor = Colors.grey;
                                        // _setDownloadReelsText = "Downloaded";
                                      });
                                    }
                                  },
                            icon: Icon(Icons.download_rounded,
                                color: Colors.white),
                            color: _setDownloadColor,
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
    ));
  }

  void download() async {
    print("Reels link: " + reelsLink);

    var reelsDownloadLink = await flutterInsta.downloadReels(reelsLink);

    print("reelsDownloadLink: " + reelsDownloadLink);

    final taskId = await FlutterDownloader.enqueue(
      url: reelsDownloadLink,
      savedDir: '/sdcard/Download',
      showNotification: true,
      fileName: "instagramdownloader_reels.mp4",
      openFileFromNotification: true,
    ).whenComplete(() {
      setState(() {
        print("download completed");
        downloading = false;
      });
    });
  }
}
