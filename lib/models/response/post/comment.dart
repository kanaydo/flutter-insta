import '../../base_model/comment.dart';
import '../../base_model/user.dart';

class Comments {
  Comment _comment;
  User _user;

  Comments(comments){
    _comment = new Comment(comments["comment"]);
    _user = new User(comments["user"]);
  }

  Comment get comment => _comment;
  User get user => _user;
}