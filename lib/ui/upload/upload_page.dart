import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/base_model/user.dart';
import '../../utils/session_manager.dart';
import '../../resources/provider/user_provider.dart';
import '../../resources/provider/post_provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File _image;
  int userId = 0;
  User user;
  final captionController = TextEditingController();

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

  createPost(){
    String caption = captionController.text;
    postProvider.createNewPost(userId, caption, _image);
  }

  @override
  void initState() {
    super.initState();
    sessionManager.getSessionUserId().then((result){
      setState(() {
        userId = result;
      });
      userProvider.fetchUserDetail(userId).then((result){
        setState(() {
          user = result.user;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _image = null;
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
            onTap: createPost,
          ),
          SizedBox(width: 20)
        ],
        elevation: 0,
      ),
      body: Container(
        child: _image == null
            ? Center(
              child: GestureDetector(
                onTap: showDialogPickImage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      size: 100.0,
                      color: Colors.black12,
                    ),
                    Text(
                      "tap to load image",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black12
                      ),
                    )
                  ],
                ),
              ),
            )
            : createPostForm(_image),
      ),
    );
  }

  Widget createPostForm(File image){
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
                  image: NetworkImage(user.avatar),
              )
            ),
          ),
          SizedBox(width: 8.0,),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                border: null,
                hintText: 'enter caption..',
              ),
              controller: captionController,
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