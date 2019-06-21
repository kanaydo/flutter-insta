import '../../utils/const.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _username;
  String _passwordDigest;
  String _createdAt;
  String _updatedAt;
  String _avatarFileName;
  String _avatarContentType;
  int _avatarFileSize;
  String _avatarUpdatedAt;
  String _caption;
  String _avatar;

  User(user){
    _id = user["id"];
    _name = user["name"];
    _email = user["email"];
    _username = user["username"];
    _passwordDigest = user["password_digest"];
    _createdAt = user["created_at"];
    _updatedAt = user["updated_at"];
    _avatarFileName = user["avatar_file_name"];
    _avatarContentType = user["avatar_content_type"];
    _avatarFileSize = user["avatar_file_size"];
    _avatarUpdatedAt = user["avatar_updated_at"];
    _caption = user["caption"];
    _avatar = user["avatar"];
  }

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get username => _username;
  String get passwordDigest => _passwordDigest;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get avatarFileName => _avatarFileName;
  String get avatarContentType => _avatarContentType;
  int get avatarFileSize => _avatarFileSize;
  String get avatarUpdatedAt => _avatarUpdatedAt;
  String get caption => _caption;
  String get avatar => "http://$base_url$_avatar";
}