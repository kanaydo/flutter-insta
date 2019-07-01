import 'package:flutter/material.dart';
import 'ui/profile/profile_page.dart';
import 'ui/feed/feed_page.dart';
import 'ui/explore/explore_page.dart';
import 'ui/upload/upload_page.dart';
import 'ui/activity/activity_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    ExplorePage(),
    UploadPage(),
    ActivityPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: new Center(
        child: _widgetOptions.elementAt(_cIndex),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: _cIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting ,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Color.fromARGB(255, 0, 0, 0)
            ),
            title: new Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Color.fromARGB(255, 0, 0, 0)
            ),
            title: new Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_upload,
              color: Color.fromARGB(255, 0, 0, 0)
            ),
            title: new Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_important,
              color: Color.fromARGB(255, 0, 0, 0)
            ),
            title: new Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 0, 0, 0)
            ),
            title: new Text('')
          )
        ],
        onTap: (index){
            _incrementTab(index);
        },
      ) 
    );
  }
}
