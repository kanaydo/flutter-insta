import '../../utils/const.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../../models/response/post_response.dart';
import '../../models/response/feed_response.dart';
import '../../models/response/post/show.dart';
import '../../models/response/post/explore.dart';

class PostProvider {
 
  final client = Client();

  Future<PostResponse> fetchUserPosts(int id) async {
    final response = await client.get('http://$base_url/api/v1/users/$id/posts');
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<FeedResponse> fecthFeeds(int id) async {
    final response = await client.get("http://$base_url/api/v1/posts/feed?id=$id");
    if(response.statusCode == 200) {
      return FeedResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load feed");
    }
  }

  Future<ShowPostResponse> fetchPostDetails(int postId) async {
    final response = await client.get("http://$base_url/api/v1/posts/$postId");
    if(response.statusCode == 200){
      return ShowPostResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load post details");
    }
  }

  Future<ExploreResponse> fetchPostExplore() async {
    final response = await client.get("http://$base_url/api/v1/posts/explore");
    if(response.statusCode == 200){
      return ExploreResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to explore posts");
    }
  }

}