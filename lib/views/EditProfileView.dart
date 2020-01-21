
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/FirebaseAuthentication.dart';
import 'package:image_picker/image_picker.dart';

File _image;

class EditProfileView extends StatefulWidget {
  final User user;

  const EditProfileView({Key key, this.user}) : super(key: key);

  @override
  _EditProfileView createState() => _EditProfileView();
}

class _EditProfileView extends State<EditProfileView> {
  StorageReference _reference;

  Future<String> downloadImage() async {
    String _downloadUrl = await _reference.getDownloadURL();
    print(_downloadUrl);

    return _downloadUrl;
  }

  Future getImageFromGallery () async {
    var image = await ImagePicker .pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  
  Future uploadImageToFirebaseStorage () async {
    _image.rename(widget.user.name + '.png');
    StorageReference storageReference = FirebaseStorage.instance.ref().child(widget.user.name + '.png');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    setState(() {
      print('Succesfull');
    });
  }

  @override
  void initState() {
    _image = null;
    _reference = FirebaseStorage.instance.ref().child(widget.user.urlProfile);
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
        future: downloadImage(),
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
                      changePhotoButton(context)
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
      backgroundImage: (_image != null) ? AssetImage(_image.path) : NetworkImage(url)
    );
  }

  Widget changePhotoButton (BuildContext context) {
    return IconButton (
      icon: Icon (Icons.add_a_photo, color: Color.fromRGBO(210, 206, 229, 1)),
      onPressed: () async {
        getImageFromGallery();
      },
    );
  }

  Widget saveButton (BuildContext context) {
    return FlatButton (
      onPressed: () async {
       await uploadImageToFirebaseStorage();
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
        await updateUserInformation(widget.user);
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