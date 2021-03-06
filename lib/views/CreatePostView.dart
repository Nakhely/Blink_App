
import 'dart:io';

import 'package:Blink/services/ImagePickerController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Blink/models/User.dart';
import 'package:Blink/services/FirebaseStorage.dart';
import 'package:image_picker/image_picker.dart';

PickedFile _image;
String _message;

class CreatePostView extends StatefulWidget {
  final User user;

  const CreatePostView({Key key, this.user}) : super(key: key);

  @override
  _CreatePostView createState() => _CreatePostView();
}

class _CreatePostView extends State<CreatePostView> {

  @override
  void initState() {
    _image = null;
    super.initState();
  }

  Future<void> _alert (BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select a photo and write a message'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold (
      appBar: AppBar (
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        automaticallyImplyLeading: false,
        title: Text ('New post'),
      ),
      backgroundColor: Color.fromRGBO(71, 67, 93, 1),
      body: Container (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Expanded (
            child: Align (
              alignment: Alignment.center,
              child: ListView (
                shrinkWrap: true,
                children: <Widget>[
                  if (_image != null)
                    Visibility (
                      visible: (_image == null) ? false : true,
                      child: Row (
                        children: <Widget>[
                          Container (
                            height: 400,
                            width: media.width,
                            decoration: BoxDecoration (
                              image: DecorationImage(
                                image: FileImage( File( _image.path ) ),
                                fit: BoxFit.cover,
                                alignment: Alignment.center
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                  Visibility (
                      visible: (_image == null) ? true : false,
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container (
                            height: 400,
                            child: changePhotoButtonFromGallery(context),
                          )
                        ],
                      )
                  ),
                  Container (
                    width: media.width,
                    color: Colors.white,
                    child: Column (
                      children: <Widget>[
                        Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row (
                            children: <Widget>[
                              Expanded (
                                child: inputPostMessage(context),
                              )
                            ],
                          ),
                        ),
                        
                        Padding (
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              changePhotoButtonFromGalleryAgain(context),
                              sendPost(context)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget changePhotoButtonFromGallery (BuildContext context) {
    return IconButton (
      iconSize: 80,
      icon: Icon (Icons.add_photo_alternate, color: Color.fromRGBO(210, 206, 229, 1)),
      onPressed: () async {
        PickedFile image = await getImageFromGallery();
        setState(() {
          _image = image;
        });
      },
    );
  }

  Widget changePhotoButtonFromGalleryAgain (BuildContext context) {
    return IconButton (
      iconSize: 35,
      icon: Icon (Icons.add_photo_alternate, color: Color.fromRGBO(71, 67, 93, 1)),
      onPressed: () async {
        PickedFile image = await getImageFromGallery();
        setState(() {
          _image = image;
        });
      },
    );
  }

  Widget sendPost (BuildContext context) {
    return IconButton (
      iconSize: 35,
      icon: Icon (Icons.send, color: Color.fromRGBO(71, 67, 93, 1)),
      onPressed: () async {
        if (_image == null || _message == null) {
          _alert(context);
        } else {
          String userName = widget.user.name + ' ' + widget.user.firstSurname + ' ' + widget.user.secondSurname;
          publisPost(context, File(_image.path), _message, userName, widget.user.id);
        }
      },
    );
  }

  Widget inputPostMessage (BuildContext context) {
    return TextFormField (
        onChanged: (value) => _message = value ,
        maxLines: null,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(33, 33, 33, 1)
        ),
        decoration: decorationInput('What do you think?')

    );
  }

  InputDecoration decorationInput(String hintText) {
    return InputDecoration(
        hintText: hintText,

        hintStyle: TextStyle(
            color: Color.fromRGBO(33, 33, 33, 0.5)
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(71, 67, 93, 1))
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(71, 67, 93, 1))
        )
    );
  }

}
