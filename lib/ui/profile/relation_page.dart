import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'follower_page.dart';
import 'following_page.dart';
import '../../utils/session_manager.dart';

class RelationPage extends StatefulWidget {
  @override
  _RelationPageState createState() => _RelationPageState();
}

class _RelationPageState extends State<RelationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "120",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "20",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    Text(
                      "Following",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )
                  ],
                ),
              ],
            ),
        ),
          ),
        body: TabBarView(
          children: [
            FollowerPage(),
            FollowingPage()
          ],
        ),
      ),
    );
  }
}