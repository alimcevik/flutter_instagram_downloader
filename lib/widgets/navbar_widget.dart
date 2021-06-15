import 'package:downloader/design.dart';
import 'package:downloader/widgets/dialogs_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:downloader/screens/reels_page.dart';
import 'package:downloader/screens/search_page.dart';
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
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: pink,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
