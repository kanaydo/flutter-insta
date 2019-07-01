import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:convert';
import '../../models/response/user_profile_response.dart';
import '../../models/response/user/registration_response.dart';
import '../../models/response/user/relation_response.dart';
import '../../models/response/user/relation_status_response.dart';

import '../../utils/const.dart';

class UserProvider {

  final client = Client();

  Future<UserResponse> fetchUserDetail(int id) async {
    final response = await client.get('http://$base_url/api/v1/users/$id');
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<SessionResponse> createNewUser(String name, String username, String email, String password) async {
    Map<String, String> body = {
      "name": name,
      "username": username,
      "email": email,
      "password": password
    };
    final response = await client.post("http://$base_url/api/v1/users", body: body);
    if(response.statusCode == 200 || response.statusCode == 422){
      print(response.body);
      return SessionResponse.fronJson(json.decode(response.body));
    }else{
      throw Exception("Failed to register user");
    }
  }

  Future<SessionResponse> loginUser(String username, String password) async {
    Map<String, String> body = {
      "username": username,
      "password": password
    };
    final response = await client.post("http://$base_url/api/v1/sessions", body: body);
    if(response.statusCode == 200 || response.statusCode == 422){
      return SessionResponse.fronJson(json.decode(response.body));
    }else{
      throw Exception("Failed to login user");
    }
  }

  Future<RelationResponse> fecthUserFollowers(int userId) async {
    final response = await client.get('http://$base_url/api/v1/users/$userId/followers');
    if(response.statusCode == 200){
      return RelationResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed fetch user followers");
    }
  }

  Future<RelationResponse> fecthUserFollowing(int userId) async {
    final response = await client.get("http://$base_url/api/v1/users/$userId/following");
    if(response.statusCode == 200){
      print(response.body);
      return RelationResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed fetch user following");
    }
  }

  Future updateUserProfile(int userId, String name, String username, String email, String caption, File image) async {
    var uri = Uri.parse("http://$base_url/api/v1/users/$userId");
    var request = http.MultipartRequest("PATCH", uri);
    if(image != null){
      var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var multipartFile = new http.MultipartFile('avatar', stream, length, filename: basename(image.path));
      request.files.add(multipartFile);
    }
    request.fields['name'] = name;
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['caption'] = caption;
    final response = await request.send();
    if(response.statusCode == 200){
       print(response.toString());
    }
  }

  Future<RelationStatusResponse> fetchUserRelationStatus(int userId, int friendId) async {
    final response = await client.get('http://$base_url/api/v1/users/$friendId/check_relation?user_id=$userId');
    if (response.statusCode == 200) {
      return RelationStatusResponse.fronJson(json.decode(response.body));
    }else{
      throw Exception('Failed To Load user Relation');
    }
  }
}

final userProvider = UserProvider();