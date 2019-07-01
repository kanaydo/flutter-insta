import 'package:flutter/material.dart';
import 'package:nested_navigation/models/response/post/comment.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/post/comment_detail.dart';

class CommentPage extends StatefulWidget {
  final int postId;
  CommentPage({@required this.postId});
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    super.initState();
    postBloc.fetchPostComments(widget.postId);
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
        elevation: 0,
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
      ),
      body: Container(
        child: StreamBuilder<PostCommentsResponse>(
          stream: postBloc.postCommentsStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? buildCommentSection(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  Widget buildCommentSection(PostCommentsResponse postCommentsResponse) {
    return ListView(      
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
               Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(postCommentsResponse.user.avatar)
                  )
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: new TextSpan(
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                              text: postCommentsResponse.user.username,
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          new TextSpan(text: " "),
                          new TextSpan(text: "${postCommentsResponse.post.caption}"),
                        ],
                      ),
                    ),
                    Text(
                      postCommentsResponse.post.postAge(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        buildCommentsList(postCommentsResponse.comments)
      ],
    );
  }

  Widget buildCommentsList(List<CommentDetail> comments){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),          
          child: Row(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(comments[index].user.avatar)
                  )
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                          text: comments[index].user.username,
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: " "),
                        new TextSpan(text: "${comments[index].comment.comment}"),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        comments[index].comment.commentTime(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      InkWell(
                        onTap: (){},
                        child: Text(
                          'Reply',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
