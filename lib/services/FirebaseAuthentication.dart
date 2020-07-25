
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Blink/models/User.dart';
import 'package:progress_dialog/progress_dialog.dart';

void registerUser(User user, BuildContext context, String email, String password) {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal,'Please wait');
  _progressDialog.show();

  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((currentUser) => Firestore.instance
      .collection("users").document(currentUser.uid)
      .setData({
          "id" : currentUser.uid,
          "name" : user.name,
          "first_surname" : user.firstSurname,
          "second_surname" : user.secondSurname,
          "has_profile" : user.hasProfile,
      }
      )
  ).then((result) => {
    print('Succesfull'),
    _progressDialog.hide(),
    _alert(context)
  }).catchError((error) => print(error)).catchError((error2) => print(error2));
}

Future<User> loginUser(String email, String password, BuildContext context) async {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();
  
  User user;
  String _id, _name, _first_surname, _second_surname;
  bool _hasProfile;

  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((currentUser) => Firestore.instance
      .collection('users').document(currentUser.uid).get()
      .then((DocumentSnapshot result) {
        _id = currentUser.uid;
        _name = result['name'];
        _first_surname = result['first_surname'];
        _second_surname = result['second_surname'];
        _hasProfile = result['has_profile'];

        user = User(_id, _name, _first_surname, _second_surname, _hasProfile);
        _progressDialog.hide();
        print(user.name + user.firstSurname + user.secondSurname + user.hasProfile.toString());
      }).catchError((error) {}).catchError((error2) => print(error2))).catchError((error3) {
    _progressDialog.hide();
    _alertErrorAuthentication(context);
  });

      return user;
}

Future updateUserInformation (User user, BuildContext context) async {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();
  Firestore.instance.collection('users').document(user.id).setData({
    "id" : user.id,
    "name" : user.name,
    "first_surname" : user.firstSurname,
    "second_surname" : user.secondSurname,
    "has_profile" : user.hasProfile,
  }).then((result) {
    _progressDialog.hide();
    _alertUpdateProfileData(context);
  }).catchError((error) => print(error));
}

Future<void> _alert (BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Registered Successfully'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/');
            },
          )
        ],
      );
    }
  );
}

Future<void> _alertErrorAuthentication (BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incorrect sign in'),
          content: Text (' Email or password incorrect '),
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

Future<void> _alertUpdateProfileData (BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User data updated'),
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


ProgressDialog progressDialog (BuildContext context, ProgressDialogType progressDialogType, String message) {
  ProgressDialog progressDialog = ProgressDialog (context, type: progressDialogType, isDismissible: true);
  progressDialog.style(message: message);

  return progressDialog;
}