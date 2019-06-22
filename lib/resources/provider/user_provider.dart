import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../../models/response/user_profile_response.dart';
import '../../models/response/user/registration_response.dart';
import '../../models/response/user/relation_response.dart';
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
      return RelationResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed fetch user following");
    }
  }

}

final userProvider = UserProvider();