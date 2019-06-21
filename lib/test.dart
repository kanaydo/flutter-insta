import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        actions: <Widget>[
          Icon(Icons.face)
        ],
      ),
      body: Container(
        child: Center(
          child: Text("ini test"),
        ),
      ),
    );
  }
}