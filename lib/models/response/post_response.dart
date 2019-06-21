import '../base_model/post.dart';

class PostResponse {
  String _message;
  List<Post> _posts;

  PostResponse.fromJson(Map<String, dynamic> map){
    _message = map["message"];
    List<Post> temp = [];
    for(int i=0; i<map['posts'].length; i++){
      Post post = new Post(map['posts'][i]);
      temp.add(post);
    }
    _posts = temp;
  }

  String get message => _message;
  List<Post> get posts => _posts;
}