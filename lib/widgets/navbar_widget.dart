import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_picture/screens/reels_page.dart';
import 'package:profile_picture/screens/search_page.dart';
import 'package:profile_picture/widgets/appbar_widget.dart';
import '../screens/about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      SearchPage(),
      ReelsPage(),
      about(context),
    ];

    return WillPopScope(
      onWillPop: () async {
        return showAlertExitDialog(context);
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              Container(
                height: 80,
                //   child: appbar(),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.search,
                size: 19,
              ),
              label: 'Profile Picture',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.video,
                size: 19,
              ),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_sharp),
              label: 'About',
            ),
            /*BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Exit',
            ),*/
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  showAlertExitDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "EXIT",
        style: TextStyle(color: mor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        SystemNavigator.pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want exit to app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
