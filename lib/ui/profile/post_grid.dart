import 'package:flutter/material.dart';
import '../../models/response/post_response.dart';
import '../../models/base_model/post.dart';
import '../../resources/blocs/post_bloc.dart';
import '../feed/show_post_page.dart';

class PostGrid extends StatefulWidget {
  @override
  _PostGridState createState() => _PostGridState();
}

class _PostGridState extends State<PostGrid> {
  @override
  void initState() {
    super.initState();
    postBloc.fecthUserPosts(5);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostResponse>(
      stream: postBloc.userPostsStream,
      builder: (context, snapshot) {
        return snapshot.hasData? Container(
          child: Center(
            child: createPostGrid(snapshot.data.posts),
          ),
        ) :
        Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget createPostGrid(List<Post> posts){
    return GridView.builder(
      itemCount: posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowPostPage(postId: posts[index].id,)),
                );
              },
              child: Container(
                child: Image.network(
                  posts[index].image,
                  fit: BoxFit.cover,
                ),
              ),
              
            ),
          );
      }
    );
  }
}