import 'package:flutter/material.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/feed_response.dart';
import '../../models/base_model/feed.dart';
import '../profile/profile_page.dart';
import '../../utils/session_manager.dart';
import 'comment_page.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  int userId = 0;

  @override
  void initState() {
    super.initState();
    sessionManager.getSessionUserId().then((result){
      setState(() {
        userId = result;
      });
      postBloc.fetchUserFeed(userId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "Instagram",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0
              ),
            )
          ],
        ),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.tv,
              color: Colors.black
            ),
            onTap: () {
              
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 8
          ),
          InkWell(
            child: Icon(
              Icons.send,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          SizedBox(width: 20)
        ],
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder<FeedResponse>(
            stream: postBloc.feedStream,
            builder: (context, snapshot) {
              return snapshot.hasData ? 
              Container(
                child: createPostList(snapshot.data.feeds),
              ) :
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          )
        ],
      ),
    );
  }

  Widget createPostList(List<Feed> feeds){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: feeds.length,
      itemBuilder: (context, int index){
        return feedItem(feeds[index]);
      },
    );
  }

  Widget feedItem(Feed feed){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(feed.user.avatar)
                          )
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      Text(feed.user.username),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(""),
                ),
                Icon(Icons.more_vert)
              ],
            ),
          ),
          Container(
            height: 200.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.center,
                image: new NetworkImage(feed.image),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.favorite_border),
                SizedBox(width: 8.0,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: feed.id,)));
                  },
                  child: Icon(Icons.comment)
                ),
                SizedBox(width: 8.0,),
                Icon(Icons.send),
                Expanded(
                  child: Text(""),
                ),
                Icon(Icons.bookmark_border)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: feed.user.username, style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: " "),
                      new TextSpan(text: "${feed.caption}"), 
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
            child: Text(
              feed.createdAt.substring(0, 10),
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
}