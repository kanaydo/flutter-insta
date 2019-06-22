import 'package:flutter/material.dart';
import '../../resources/blocs/user_bloc.dart';
import '../../models/response/user/relation_response.dart';
import '../../utils/session_manager.dart';
import '../../models/base_model/user.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  
  int userId = 0;

  @override
  void initState() {
    super.initState();
    sessionManager.getSessionUserId().then((result){
      setState(() {
        userId = result;
      });
      userBloc.fetchUserFollowers(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RelationResponse>(
      stream: userBloc.userFollowersStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: snapshot.hasData ?
          userList(snapshot.data.relations) :
          Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }

  Widget userList(List<User> users){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return userItem(users[index]);
      },
    );
  }

  Widget userItem(User user){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(user.avatar)
              )
            ),
          ),
          SizedBox(width: 16.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.username,
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                  ),
                )
              ],
            ),
          ),
          Icon(Icons.more_vert)
        ],
      ),
    );
  }
}