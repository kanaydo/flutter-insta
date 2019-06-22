import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {

  final int userId;
  final String username;
  final String name;
  final String email;
  final String avatar;
  final String bio;

  EditProfilePage({
    @required this.userId,
    this.username,
    this.name,
    this.email,
    this.avatar,
    this.bio
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    usernameController.text = widget.username;
    emailController.text = widget.email;
    bioController.text = widget.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.check,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.avatar)
                      )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    "Change Profile Photo",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          style: TextStyle(
                            fontSize: 12.0
                          ),
                          controller: nameController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          style: TextStyle(
                            fontSize: 12.0
                          ),
                          controller: usernameController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Email',
                          ),
                          style: TextStyle(
                            fontSize: 12.0
                          ),
                          controller: emailController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Bio",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Bio',
                          ),
                          style: TextStyle(
                            fontSize: 12.0
                          ),
                          controller: bioController,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}