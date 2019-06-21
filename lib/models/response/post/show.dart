import '../../base_model/post.dart';
import '../../base_model/user.dart';
import 'comment.dart';

class ShowPostResponse {
  String _message;
  Post _post;
  User _user;
  List<Comments> _comments = [];

  ShowPostResponse.fromJson(Map<String, dynamic> map){
    _message = map["message"];
    _post = new Post(map["post"]);
    _user = new User(map["user"]);
    List<Comments> temp = [];
    for(int i=0; i<map["comments"].length; i++){
      Comments comments = new Comments(map["comments"][i]);
      temp.add(comments);
    }
    _comments = temp;
  }

  String get message => _message;
  Post get post => _post;
  User get user => _user;
  List<Comments> get comments => _comments;
}