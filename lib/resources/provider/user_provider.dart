import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/response/user_profile_response.dart';
import '../../utils/const.dart';

class UserProvider {

  Future<UserResponse> fetchUserDetail(int id) async {
    final response = await http.get('http://$base_url/api/v1/users/$id');
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}