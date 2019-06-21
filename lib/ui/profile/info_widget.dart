import 'package:flutter/material.dart';

class ProfileInfoPanel extends StatefulWidget {

  final String title, value;

  ProfileInfoPanel({
    this.title,
    this.value
  });

  @override
  _ProfileInfoPanelState createState() => _ProfileInfoPanelState();
}

class _ProfileInfoPanelState extends State<ProfileInfoPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              widget.value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}