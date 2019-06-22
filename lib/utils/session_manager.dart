import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'const.dart';

class SessionManager {

  Future<int> getSessionUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdSessionKey) ?? 0;
  }

  setSessionUserId(int userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setInt(userIdSessionKey, userId);
  }

   Future<bool> getLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoginStatus) ?? false;
  }

  setLoginStatus(bool status) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool(userLoginStatus, status);
  }

}

final sessionManager = SessionManager();