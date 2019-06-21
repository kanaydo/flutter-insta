import 'package:flutter/material.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
            ),
            RaisedButton(
              child: Text('SignIn'),
              onPressed: (){},
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