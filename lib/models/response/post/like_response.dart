import 'package:nested_navigation/models/base_model/post.dart';

class LikeResponse{
  int _status;
  String _message;
  Post _post;

  LikeResponse.fromJson(Map<String, dynamic> map){
    _status = map['status'];
    _message = map['message'];
    _post = new Post(map['post']);
  }

  int get status => _status;
  String get message => _message;
  Post get post => _post;
}