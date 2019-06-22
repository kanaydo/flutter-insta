import 'package:flutter/material.dart';
import 'package:nested_navigation/utils/session_manager.dart';
import 'registration_page.dart';
import '../../resources/provider/user_provider.dart';
import '../../app.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  _authenticateUser(){
    String username = usernameController.text;
    String password = passwordController.text;
    userProvider.loginUser(username, password).then((result){
      print(result.message);
      if(result.status == 200){
        sessionManager.setSessionUserId(result.user.id);
        sessionManager.setLoginStatus(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => App()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'SignIn Screen',
              style: TextStyle(fontSize: 26.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter username',
              ),
              controller: usernameController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
              controller: passwordController,
            ),
            RaisedButton(
              child: Text('SignIn'),
              onPressed: _authenticateUser,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              children: <Widget>[
                Text("Belum punya akun? "),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text(
                    "Daftar Disini!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}