import 'package:flutter/material.dart';
import '../../resources/blocs/post_bloc.dart';
import '../../models/response/post/explore.dart';
import '../../models/base_model/post.dart';
import '../feed/show_post_page.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  void initState() {
    super.initState();
    postBloc.fetchExplorePost();
  }

  @override
  void dispose() {
    super.dispose();
    postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.select_all,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          SizedBox(width: 20)
        ],
        elevation: 0,
        bottom: PreferredSize(child: Container(color: Colors.grey, height: 1.0,), preferredSize: Size.fromHeight(-10.0)),
      ),
      body: StreamBuilder<ExploreResponse>(
        stream: postBloc.explorePostStream,
        builder: (context, snapshot) {
          return snapshot.hasData ?
          Container(
            child: buildExplore(snapshot.data.posts),
          ) :
          Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }

  Widget buildExplore(List<Post> posts){
    return GridView.builder(
      itemCount: posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      //physics: new NeverScrollableScrollPhysics(),
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