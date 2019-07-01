import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';

import '../../utils/const.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/response/post_response.dart';
import '../../models/response/feed_response.dart';
import '../../models/response/post/show.dart';
import '../../models/response/post/explore.dart';
import '../../models/response/post/comment_detail.dart';

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

  Future<PostCommentsResponse> fecthPostComments(int postId) async {
    final response = await client.get('http://$base_url/api/v1/posts/$postId/comments');
    if(response.statusCode == 200){
      return PostCommentsResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to fecth post comments');
    }
  }

  Future<PostResponse> createNewPost(int userId, String caption, File image) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse("http://$base_url/api/v1/posts");
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile('image', stream, length, filename: basename(image.path));
    request.files.add(multipartFile);
    request.fields['user_id'] = "$userId";
    request.fields['caption'] = caption;
    final response = await request.send();
    if(response.statusCode == 200){
      print(response.toString());
    }
  }
}

final postProvider = PostProvider();