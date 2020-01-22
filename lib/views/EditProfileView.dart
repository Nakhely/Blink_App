
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/FirebaseAuthentication.dart';
import 'package:flutter_app/services/FirebaseStorage.dart';
import 'package:image_picker/image_picker.dart';

File _image;

class EditProfileView extends StatefulWidget {
  final User user;

  const EditProfileView({Key key, this.user}) : super(key: key);

  @override
  _EditProfileView createState() => _EditProfileView();
}

class _EditProfileView extends State<EditProfileView> {
  Future getImageFromGallery () async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromCamera () async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        title: Text ('Edit profile'),
      ),
      backgroundColor: Color.fromRGBO(71, 67, 93, 1),
      body: FutureBuilder (
        future: (widget.user.hasProfile == true) ? downloadImage(widget.user.id) : downloadImage('default.png'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container (
              child: Column (
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding (
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: profilePicture(context, snapshot.data),
                      ),
                    ],
                  ),

                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      changePhotoButtonFromGallery(context),
                      changePhotoButtonFromCamera(context)
                    ],
                  ),

                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      saveButton(context),
                    ],
                  ),

                  Expanded (
                    child: ListView (
                      children: <Widget>[
                        Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          child: nameField(context, 'Name', 'Write your new name'),
                        ),
                        Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          child: firstSurnameField(context, 'First surname', 'Write your new first surname')
                        ),
                        Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          child: secondSurnameField(context, 'Second surname', 'Write your new second surname'),
                        ),
                        Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          child: saveInformationButton(context)
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  Widget profilePicture(BuildContext context, String url)  {
    return CircleAvatar (
      backgroundColor: Color.fromRGBO(210, 206, 229, 1),
      radius: 70.0,
      backgroundImage: (_image != null) ? FileImage(_image) : NetworkImage(url)
    );
  }

  Widget changePhotoButtonFromGallery (BuildContext context) {
    return IconButton (
      icon: Icon (Icons.photo_library, color: Color.fromRGBO(210, 206, 229, 1)),
      onPressed: () async {
        getImageFromGallery();
      },
    );
  }

  Widget changePhotoButtonFromCamera (BuildContext context) {
    return IconButton (
      icon: Icon (Icons.add_a_photo, color: Color.fromRGBO(210, 206, 229, 1)),
      onPressed: () async {
        getImageFromCamera();
      },
    );
  }

  Widget saveButton (BuildContext context) {
    return FlatButton (
      onPressed: () async {
       await uploadImageToFirebaseStorage(context, widget.user, widget.user.id, _image);
       widget.user.hasProfile = true;
      },
      child: Text (
        'Save profile picture',
        style: TextStyle (
            color: Color.fromRGBO(210, 206, 229, 1),
            fontSize: 19
        ),
      ),
    );
  }

  Widget nameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => widget.user.name = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
      controller: TextEditingController(text: widget.user.name),
    );
  }

  Widget firstSurnameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => widget.user.firstSurname = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
      controller: TextEditingController(text: widget.user.firstSurname),
    );
  }

  Widget secondSurnameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => widget.user.secondSurname = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
      controller: TextEditingController(text: widget.user.secondSurname),
    );
  }

  InputDecoration decorationInput(String labelName, String hintText) {
    return InputDecoration (
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color.fromRGBO(210, 206, 229, 1)
        ),

        labelText: labelName,
        labelStyle: TextStyle(
            color: Color.fromRGBO(210, 206, 229, 1)
        ),

        enabledBorder: OutlineInputBorder (
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
        ),

        focusedBorder: OutlineInputBorder (
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
        )
    );
  }

  Widget saveInformationButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async{
        await updateUserInformation(widget.user, context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(210, 206, 229, 1),
      child: Text(
        'Update',
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

}