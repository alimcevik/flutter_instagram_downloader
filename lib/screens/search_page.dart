import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_picture/utils/methods.dart';
import 'package:profile_picture/widgets/appbar_widget.dart';

TextEditingController _inputSearch = TextEditingController();

class SearchPage extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

String usernameState, followerState, followingState, imageUrlState;

class _SeaState extends State<SearchPage> {
  int _progress = 0;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;
  String _setDownloadText = "Download Profil Picture [HD]";
  Color _setDownloadColor = mor;
  bool downloading = false;
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();

    _inputSearch.clear();
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
                /*onChanged: (value) {
                  setState(() {
                    _setDownloadText = "Download Profil Picture [HD]";
                    _setDownloadColor = mor;
                  });
                },*/
                controller: _inputSearch,
                decoration: InputDecoration(
                    hintText: "Enter username",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: mor),
                onPressed: () async {
                  FocusScope.of(context).nextFocus();
                  instagramuser = _inputSearch.text.toString();

                  print("Search " + instagramuser);
                  //getPost(instagramuser);
                  await flutterInsta.getProfileData(instagramuser);
                  setState(() {
                    _isButtonDisabled = false;
                    usernameState = flutterInsta.username;
                    followerState = flutterInsta.followers;
                    followingState = flutterInsta.following;
                    imageUrlState = flutterInsta.imgurl;
                  });

                  //  getPost(instagramuser);
                },
              ),
              /* IconButton(
              icon: Icon(Icons.notifications, color: mor),
              onPressed: () {},
            )*/
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
                                color: mor, size: 17),
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

                                      download(imageUrlState);

                                      setState(() {
                                        _isButtonDisabled = true;
                                        downloading = true;
                                        _setDownloadColor = Colors.grey;
                                        _setDownloadText = "Downloaded";
                                      });
                                      /*
                                _downloadImage(
                                  "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png",
                                  //  "$imageUrlState",
                                  outputMimeType: "image/png",
                                ).then((value) => {
                                      setState(() {
                                        downloading = true;
                                        _setDownloadColor = Colors.grey;
                                        _setDownloadText = "Downloaded";
                                      })
                                    });*/
                                    }

                                    //launch(imageUrlState);
                                  },
                            icon: Icon(Icons.download_rounded,
                                color: Colors.white),
                            color: _setDownloadColor,
                            label: Text(
                              "$_setDownloadText",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage("assets/icon.png"),
                                radius: 30,
                              ),
                              Container(width: 15),
                              Column(
                                children: [
                                  Text(
                                    "User Name\n" + "0 Followers | 0 Following",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ListTile(
                            leading: new Icon(FontAwesomeIcons.info,
                                color: mor, size: 17),
                            title: Text("Bio"),
                            subtitle: new Text(
                              "Welcome to Insta Downloader!",
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
    ));
  }

  Future<void> _downloadImage(
    String url, {
    AndroidDestinationType destination,
    bool whenError = false,
    String outputMimeType,
  }) async {
    String fileName;
    String path;
    int size;
    String mimeType;
    try {
      String imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url,
                outputMimeType: outputMimeType)
            .catchError((error) {
          if (error is PlatformException) {
            String path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
            setState(() {
              _message = error.toString();
              _path = path ?? '';
            });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          return;
        });
      } else {
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          );
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      size = await ImageDownloader.findByteSize(imageId);
      mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      setState(() {
        _message = error.message ?? '';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      var location = Platform.isAndroid ? "Directory" : "Photo Library";
      _message = 'Saved as "$fileName" in $location.\n';
      _size = 'size:     $size';
      _mimeType = 'mimeType: $mimeType';
      _path = path ?? '';

      if (!_mimeType.contains("video")) {
        _imageFile = File(path);
      }
      return;
    });
  }

  void download(imageUrlState) async {
    final taskId = await FlutterDownloader.enqueue(
      url: imageUrlState,
      savedDir: '/sdcard/Download',
      showNotification: true,
      openFileFromNotification: true,
      fileName: "instadownloader_$usernameState.jpg",
    ).whenComplete(() {
      setState(() {
        print("indirme tamamlandı");
        downloading = false; // set to false to stop Progress indicator
      });
    });
  }
}
