class Comment {
  int _id;
  int _userId;
  int _postId;
  String _comment;
  String _createdAt;
  String _updatedAt;

  Comment(comment){
    _id = comment["id"];
    _userId = comment["user_id"];
    _postId = comment["post_id"];
    _comment = comment["comment"];
    _createdAt = comment["created_at"];
    _updatedAt = comment["updated_at"];
  }

  int get id => _id;
  int get userId => _userId;
  int get postId => _postId;
  String get comment => _comment;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  String commentTime(){
    final birthday = DateTime.parse(_createdAt);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    return '${difference.toString()} days';
  }
}