
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:progress_dialog/progress_dialog.dart';

void registerUser(User user, BuildContext context, String email, String password) {
  ProgressDialog progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
  progressDialog.style(message: "Please wait");
  progressDialog.show();

  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((currentUser) => Firestore.instance
      .collection("users").document(currentUser.uid)
      .setData({
          "id" : currentUser.uid,
          "name" : user.name,
          "first_surname" : user.firstSurname,
          "second_surname" : user.secondSurname,
          "profile_url" : user.urlProfile,
      }
      )
  ).then((result) => {
    print('Succesfull'),
    progressDialog.dismiss(),
    _alert(context)
  }).catchError((error) => print(error)).catchError((error2) => print(error2));
}

Future<User> loginUser(String email, String password, BuildContext context) async {
  ProgressDialog progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
  progressDialog.style(message: "Please wait");
  progressDialog.show();
  
  User user;
  String _id, _name, _first_surname, _second_surname, _url_profile;

  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((currentUser) => Firestore.instance
      .collection('users').document(currentUser.uid).get()
      .then((DocumentSnapshot result) => {
        _id = currentUser.uid,
        _name = result['name'],
        _first_surname = result['first_surname'],
        _second_surname = result['second_surname'],
        _url_profile = result['profile_url'],

        user = User(_id, _name, _first_surname, _second_surname, _url_profile),
        progressDialog.dismiss(),
        print(user.name + user.firstSurname + user.secondSurname),
      }).catchError((error) => print(error)).catchError((error2) => print(error2)));
      
      return user;
}

Future updateUserInformation (User user) async {
  Firestore.instance.collection('users').document(user.id).setData({
    "id" : user.id,
    "name" : user.name,
    "first_surname" : user.firstSurname,
    "second_surname" : user.secondSurname,
    "profile_url" : user.urlProfile,
  }).then((result) => {
    print('succesfull')
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