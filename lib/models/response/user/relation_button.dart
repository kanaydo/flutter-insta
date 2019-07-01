import 'package:flutter/material.dart';
import 'package:nested_navigation/models/base_model/user.dart';
import '../../response/user/relation_status_response.dart';
import '../../../resources/provider/user_provider.dart';

class RelationButton extends StatefulWidget {
  final User user;
  final int userId;
  RelationButton({this.userId, this.user});
  @override
  _RelationButtonState createState() => _RelationButtonState();
}

class _RelationButtonState extends State<RelationButton> {

  @override
  Widget build(BuildContext context) {
   return FutureBuilder<RelationStatusResponse>(
      future: userProvider.fetchUserRelationStatus(widget.userId, widget.user.id),
      builder: (context, snapshot){
        return snapshot.hasData ?
        userRelationButton(snapshot.data, widget.user) :
        Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget userRelationButton(RelationStatusResponse relationStatusResponse, User user){
    return relationStatusResponse.follower == true ?
    ButtonTheme(
      height: 25.0,
      child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.white,
        onPressed: () {},
        child: Text(
          "following",
          style: TextStyle(
          ),
        ),
      ),
    ) :
    ButtonTheme(
      height: 25.0,
      child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
        onPressed: () {},
        child: Text(
          "follow",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}