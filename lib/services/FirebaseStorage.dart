
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:Blink/models/User.dart';

Future<String> downloadImage(String reference) async {
  StorageReference _reference = FirebaseStorage.instance.ref().child(reference);
  String _downloadUrl = await _reference.getDownloadURL();
  print(_downloadUrl);

  return _downloadUrl;
}

Future uploadImageToFirebaseStorage (BuildContext context, User user, String reference, File image) async {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();

  await Firestore.instance.collection('users').document(user.id).setData({
    "id" : user.id,
    "name" : user.name,
    "first_surname" : user.firstSurname,
    "second_surname" : user.secondSurname,
    "has_profile" : true,
  });

  StorageReference storageReference = FirebaseStorage.instance.ref().child(reference);
  StorageUploadTask uploadTask = storageReference.putFile(image);

  StorageTaskSnapshot sts = await uploadTask.onComplete;

  _progressDialog.dismiss();
  _alertUpdateProfilePictures(context);
}

Future publisPost (BuildContext context, File image, String message, String userName, String idUser) async {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();
  String date = DateTime.now().toString();

  StorageReference storageReference = FirebaseStorage.instance.ref().child(date);
  StorageReference storageReferenceAvatar = FirebaseStorage.instance.ref().child(idUser);
  StorageUploadTask uploadTask = storageReference.putFile(image);

  StorageTaskSnapshot sts = await uploadTask.onComplete;
  String downloadUrl = await storageReference.getDownloadURL();
  String downloadUrlAvatarImage = await storageReferenceAvatar.getDownloadURL();

  await Firestore.instance.collection('posts').add({
    "message" : message,
    "url_image" : downloadUrl,
    "name_user" : userName,
    "circle_avatar" : downloadUrlAvatarImage,
    "publish_date" : date
  });

  _progressDialog.dismiss();
  _alertPublisSuccesfull(context);
}

/*Future <List<Post>> getAllPosts () async{

}*/

ProgressDialog progressDialog (BuildContext context, ProgressDialogType progressDialogType, String message) {
  ProgressDialog progressDialog = ProgressDialog (context, type: progressDialogType);
  progressDialog.style(message: message);

  return progressDialog;
}

Future<void> _alertPublisSuccesfull (BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Published correctly'),
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

Future<void> _alertUpdateProfilePictures (BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile picture updated'),
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

