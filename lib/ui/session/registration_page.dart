import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  _signUpUser(){
    String name = nameController.text;
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String passwordConfirmation = passwordConfirmationController.text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                    labelText: 'full name'
                  ),
                  controller: nameController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'username'
                  ),
                  controller: usernameController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'email'
                  ),
                  controller: emailController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'password'
                  ),
                  controller: passwordController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'password confirmation'
                  ),
                  controller: passwordConfirmationController,
                ),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: _signUpUser,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// name:Batara Kanaydo
// username:kanaydo2
// email:batara.girsang@gmail.com
// password:12345
// caption:hehehe