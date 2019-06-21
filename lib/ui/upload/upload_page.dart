import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File _image;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _image = null;
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.send,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          SizedBox(width: 20)
        ],
        elevation: 0,
        bottom: PreferredSize(child: Container(color: Colors.grey, height: 1.0,), preferredSize: Size.fromHeight(-10.0)),
      ),
      body: Container(
        child: _image == null
            ? Text('No image selected.')
            : createNewPost(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImageCamera,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget createNewPost(File image){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(avatar)
              )
            ),
          ),
          SizedBox(width: 8.0,),
          Expanded(
            child: TextField(
              //onChanged: sessionBloc.passChanged,
              keyboardType: TextInputType.text,
              autofocus: false,
              //controller: passController,
              obscureText: true,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                border: null,
                hintText: 'enter caption..',
              ),
            ),
          ),
          SizedBox(width: 8.0,),
          Container(
            width: 50,
            height: 50,
            child: Image.file(
              _image,
            )
          ),
        ],
      ),
    );
  }
}