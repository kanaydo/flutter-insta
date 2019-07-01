import 'package:flutter/material.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/post/show.dart';
import '../../models/response/post/comment.dart';
import 'comment_page.dart';

class ShowPostPage extends StatefulWidget {
  final int postId;

  ShowPostPage({@required this.postId});

  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
  @override
  void initState() {
    super.initState();
    postBloc.fetchPostDetails(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Photo",
          style: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
      ),
      body: Container(
        child: StreamBuilder<ShowPostResponse>(
            stream: postBloc.postDetailsStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? buildPostDetail(snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    );
  }

  Widget buildPostDetail(ShowPostResponse postDetail) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(postDetail.user.avatar))),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(child: Text(postDetail.user.username)),
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
                  image: new NetworkImage(postDetail.post.image),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.favorite_border),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(Icons.comment),
                    SizedBox(
                      width: 8.0,
                    ),
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
                          new TextSpan(
                              text: postDetail.user.username,
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          new TextSpan(text: " "),
                          new TextSpan(text: "${postDetail.post.caption}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: postDetail.post.id,)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildCommentList(postDetail.comments),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
                      child: Text(
                        postDetail.post.createdAt.substring(0, 10),
                        style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommentList(List<Comments> comments) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return buildCommentItem(comments[index]);
      },
    );
  }

  Widget buildCommentItem(Comments comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: comment.user.username,
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(text: " ${comment.comment.comment}"),
                ],
              ),
            ),
          ),
          Icon(
            Icons.favorite_border,
            size: 12.0,
          )
        ],
      ),
    );
  }
}
