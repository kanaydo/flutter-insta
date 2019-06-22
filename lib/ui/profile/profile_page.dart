import 'package:flutter/material.dart';
import '../../resources/blocs/user_bloc.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/user_profile_response.dart';
import '../../utils/session_manager.dart';
import 'post_grid.dart';
import 'post_list.dart';
import 'info_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int index = 0;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    sessionManager.getSessionUserId().then((result){
      setState(() {
        userId = result;
      });
      userBloc.fecthUserInfo(userId);
      postBloc.fecthUserPosts(userId);
    });
  }

  List<Widget> _widgets = [
    PostGrid(),
    PostList(),
  ];

  void _changeSubPage(int i){
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<UserResponse>(
      stream: userBloc.userInfoStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
                snapshot.data.user.username,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0
                ),
              ),
            actions: <Widget>[
              InkWell(
                child: Icon(
                  Icons.timelapse,
                  color: Colors.black
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                width: 8
              ),
              InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
              SizedBox(width: 20)
            ],
            elevation: 1,
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(snapshot.data.user.avatar)
                        )
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ProfileInfoPanel(
                                  title: "Posts",
                                  value: snapshot.data.posts.toString(),
                                ),
                                ProfileInfoPanel(
                                  title: "Followers",
                                  value: snapshot.data.followers.toString(),
                                ),
                                ProfileInfoPanel(
                                  title: "Following",
                                  value: snapshot.data.following.toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(
                                          userId: snapshot.data.user.id,
                                          name: snapshot.data.user.name,
                                          username: snapshot.data.user.username,
                                          email: snapshot.data.user.email,
                                          avatar: snapshot.data.user.avatar,
                                          bio: snapshot.data.user.caption,
                                        )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Center(
                                            child: Text(
                                              'Edit Profile', 
                                              style: TextStyle(
                                                fontSize: 12.0, 
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data.user.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      snapshot.data.user.caption,
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Story Highlights",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "Keep your favourite stories on your profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (contex, int index){
                          return index != 0 ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              shape: BoxShape.circle,
                              color: Colors.grey
                            ),
                          ) :
                          Container(
                            margin: EdgeInsets.only(right: 4.0),
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.add),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1
                    ),
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: InkWell(
                          onTap: () => _changeSubPage(0),
                          child: Center(
                            child: Icon(
                              Icons.grid_on
                              )
                            ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: InkWell(
                          onTap: () => _changeSubPage(1),
                            child: Center(
                            child: Icon(
                              Icons.format_list_bulleted
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: _widgets[index],
              )
            ],
          ),
        ) :
        Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}