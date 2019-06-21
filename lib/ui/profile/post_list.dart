import 'package:flutter/material.dart';
import '../../utils/const.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/post_response.dart';
import '../../models/base_model/post.dart';
import '../feed/show_post_page.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  @override
  void initState() {
    super.initState();
    postBloc.fecthUserPosts(5);
    print(username);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostResponse>(
      stream: postBloc.userPostsStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? 
        Container(
          child: createPostList(snapshot.data.posts),
        ) :
        Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget createPostList(List<Post> posts){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, int index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
                            image: NetworkImage(avatar)
                        )
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(child: Text(username)),
                    Icon(Icons.more_vert)
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowPostPage(postId: posts[index].id,)),
                  );
                },
                child: Container(
                  height: 200.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.center,
                      image: new NetworkImage(posts[index].image),
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8.0,),
                    Icon(Icons.comment),
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
                          new TextSpan(text: username, style: new TextStyle(fontWeight: FontWeight.bold)),
                          new TextSpan(text: " "),
                          new TextSpan(text: "${posts[index].caption}"), 
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
                child: Text(
                  posts[index].createdAt.substring(0, 10),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}