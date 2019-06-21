import '../../base_model/user.dart';

class SessionResponse {
  int _status;
  String _message;
  User _user;

  SessionResponse.fronJson(Map<String, dynamic> map){
    _message = map["message"];
    _user = new User(map["user"]);
    _status = map["status"];
  }

  String get message => _message;
  User get user => _user;
  int get status => _status;
}