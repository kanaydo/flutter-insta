import 'package:flutter/material.dart';
import 'package:nested_navigation/ui/session/login.dart';
import 'homepage.dart';
import 'utils/session_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    sessionManager.getLoginStatus().then((result){
      setState(() {
        isLoggedIn = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}