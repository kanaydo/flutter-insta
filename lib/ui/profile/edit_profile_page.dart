import 'dart:io';
import '../../resources/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  File _image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    usernameController.text = widget.username;
    emailController.text = widget.email;
    bioController.text = widget.bio;
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void updateUserProfile(){
    int userId = widget.userId;
    String name = nameController.text;
    String username = usernameController.text;
    String email = emailController.text;
    String caption = bioController.text;
    userProvider.updateUserProfile(userId, name, username, email, caption, _image);
  }

  Future<void> showDialogPickImage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: (){
                          getImageCamera();
                          Navigator.of(context).pop();
                        }
                        ,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.camera),
                            SizedBox(width: 8.0,),
                            Text('Open Camera'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: (){
                          getImageGallery();
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.image),
                            SizedBox(width: 8.0,),
                            Text('Select From Gallery'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        );
      },
    );
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
          GestureDetector(
            onTap: updateUserProfile,
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.check,
                color: Colors.blue,
              ),
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
                          image: _image == null ? NetworkImage(widget.avatar) : FileImage(_image)
                      )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: showDialogPickImage,
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