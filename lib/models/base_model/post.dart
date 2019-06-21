import '../../utils/const.dart';

class Post {
  int _id;
  String _imageFileName;
  String _imageContentType;
  int _imageFileSize;
  String _imageUpdatedAt;
  String _caption;
  int _userId;
  String _createdAt;
  String _updatedAt;
  String _image;


  Post(post){
    _id = post["id"];
    _imageFileName = post["image_file_name"];
    _imageContentType = post["image_content_type"];
    _imageFileSize = post["image_file_size"];
    _imageUpdatedAt = post["image_updated_at"];
    _caption = post["caption"];
    _userId = post["user_id"];
    _createdAt = post["created_at"];
    _updatedAt = post["updated_at"];
    _image = post["image"];
  }


  int get id => _id;
  String get imageFileName => _imageFileName;
  String get imageContentType => _imageContentType;
  int get imageFileSize => _imageFileSize;
  String get imageUpdatedAt => _imageUpdatedAt;
  String get caption => _caption;
  int get userId => _userId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => "http://$base_url$_image";
}