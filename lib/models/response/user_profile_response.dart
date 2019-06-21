import '../base_model/user.dart';

class UserResponse {
  String _message;
  User _user;
  int _followers;
  int _following;
  int _posts;

  UserResponse.fromJson(Map<String, dynamic> map){
    _message = map["message"];
    _user = new User(map["user"]);
    _followers = map["followers"];
    _following = map["following"];
    _posts = map["posts"];

  }

  String get message => _message;
  User get user => _user;
  int get followers => _followers;
  int get following => _following;
  int get posts => _posts;
}