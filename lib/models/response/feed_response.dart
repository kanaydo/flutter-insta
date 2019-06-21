import '../base_model/feed.dart';

class FeedResponse {
  String _message;
  List<Feed> _feeds;

  FeedResponse.fromJson(Map<String, dynamic> map){
    _message = map["message"];
    List<Feed> temp = [];
    for(int i=0; i<map["posts"].length; i++){
      Feed feed = new Feed(map["posts"][i]);
      temp.add(feed);
    }
    _feeds = temp;
  }

  String get message => _message;
  List<Feed> get feeds => _feeds;
}