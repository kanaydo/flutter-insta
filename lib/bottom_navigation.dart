import 'package:flutter/material.dart';
import 'ui/activity/activity_page.dart';
import 'ui/explore/explore_page.dart';
import 'ui/upload/upload_page.dart';
import 'ui/profile/profile_page.dart';
import 'ui/feed/feed_page.dart';

enum TabItem { feed, explore, upload, activity, profile }

class TabHelper {
  static TabItem item({int index}) {
    switch (index) {
      case 0:
        return TabItem.feed;
      case 1:
        return TabItem.explore;
      case 2:
        return TabItem.upload;
      case 3:
        return TabItem.activity;
      case 4:
        return TabItem.profile;
    }
    return TabItem.feed;
  }

  static String description(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.feed:
        return 'feed';
      case TabItem.explore:
        return 'explore';
      case TabItem.upload:
        return 'upload';
      case TabItem.activity:
        return 'activity';
      case TabItem.profile:
        return 'profile';
    }
    return '';
  }

  static Widget page(TabItem tabItem){
    switch (tabItem) {
      case TabItem.feed:
        return FeedPage();
      case TabItem.explore:
        return ExplorePage();
      case TabItem.upload:
        return UploadPage();
      case TabItem.activity:
        return ActivityPage();
      case TabItem.profile:
        return ProfilePage();
    }
    return FeedPage();
  }

  static IconData icon(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.feed:
        return Icons.dashboard;
      case TabItem.explore:
        return Icons.explore;
      case TabItem.upload:
        return Icons.file_upload;
      case TabItem.activity:
        return Icons.dock;
      case TabItem.profile:
        return Icons.person;
    }
    return Icons.layers;
  }

  static Widget appBar(TabItem tabItem){
    switch (tabItem) {
      case TabItem.feed:
        return AppBar(
          title: Text("feed"),
          actions: <Widget>[
            Icon(Icons.dashboard),
          ],
        );
      case TabItem.explore:
        return AppBar(
          title: Text("explore"),
          actions: <Widget>[
            Icon(Icons.explore),
          ],
        );
      case TabItem.upload:
        return AppBar(
          title: Text("upload"),
          actions: <Widget>[
            Icon(Icons.file_upload),
          ],
        );
      case TabItem.activity:
        return AppBar(
          title: Text("activity"),
          actions: <Widget>[
            Icon(Icons.face),
            Icon(Icons.history)
          ],
        );
      case TabItem.profile:
        return AppBar(
          title: Text("profile"),
          actions: <Widget>[
            Icon(Icons.face),
            Icon(Icons.favorite)
          ],
        );
    }
    return AppBar(
      title: Text("feed"),
      actions: <Widget>[
        Icon(Icons.dashboard),
      ],
    );
  }

  static MaterialColor color(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.feed:
        return Colors.red;
      case TabItem.explore:
        return Colors.green;
      case TabItem.upload:
        return Colors.blue;
      case TabItem.activity:
        return Colors.amber;
      case TabItem.profile:
        return Colors.cyan;
    }
    return Colors.grey;
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.feed),
        _buildItem(tabItem: TabItem.explore),
        _buildItem(tabItem: TabItem.upload),
        _buildItem(tabItem: TabItem.activity),
        _buildItem(tabItem: TabItem.profile)
      ],
      onTap: (index) => onSelectTab(
        TabHelper.item(index: index),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = TabHelper.description(tabItem);
    IconData icon = TabHelper.icon(tabItem);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        "",
        style: TextStyle(
          fontSize: 0.0,
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }
}