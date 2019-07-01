import 'package:nested_navigation/models/base_model/comment.dart';
import 'package:nested_navigation/models/base_model/post.dart';
import 'package:nested_navigation/models/base_model/user.dart';

class PostCommentsResponse{
  String _message;
  Post _post;
  User _user;
  List<CommentDetail> _comments = [];


  PostCommentsResponse.fromJson(Map<String, dynamic> map) {
    _message = map['message'];
    _post = new Post(map['post']);
    _user = new User(map['user']);
    List<CommentDetail> temp = [];
    for(int i=0; i<map['comments'].length; i++){
      CommentDetail comment = new CommentDetail(map['comments'][i]);
      temp.add(comment);
    }
    _comments = temp;
  }

  String get message => _message;
  Post get post => _post;
  User get user => _user;
  List<CommentDetail> get comments => _comments;
}




class CommentDetail{
  User _user;
  Comment _comment;

  CommentDetail(commentDetail){
    _user = new User(commentDetail['user']);
    _comment = new Comment(commentDetail['comment']);
  }

  User get user => _user;
  Comment get comment => _comment;
}