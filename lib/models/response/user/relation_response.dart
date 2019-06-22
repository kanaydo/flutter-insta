import '../../base_model/user.dart';

class RelationResponse {
  String _message;
  List<User> _relations;

  RelationResponse.fromJson(Map<String, dynamic> map){
    _message = map["message"];
    List<User> temp = [];
    for(int i=0; i<map["relations"].length; i++){
      User user = new User(map["relations"][i]);
      temp.add(user);
    }
    _relations = temp;
  }

  String get message => _message;
  List<User> get relations => _relations;
}