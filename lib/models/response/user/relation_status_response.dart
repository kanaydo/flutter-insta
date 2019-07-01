class RelationStatusResponse{
  String _message;
  bool _following;
  bool _follower;

  RelationStatusResponse.fronJson(Map<String, dynamic> map){
    _message = map['message'];
    _following = map['following'];
    _follower = map['follower'];
  }

  String get message => _message;
  bool get following => _following;
  bool get follower => _follower;
}