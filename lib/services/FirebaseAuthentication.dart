
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/User.dart';

void registerUser(User user) {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .then((currentUser) => Firestore.instance
      .collection("users").document(currentUser.uid)
      .setData({
          "id" : currentUser.uid,
          "name" : user.name,
          "first_surname" : user.firstSurname,
          "second_surname" : user.secondSurname,
      }
      )
  ).then((result) => {
    print('Succesfull')
  }).catchError((error) => print(error)).catchError((error2) => print(error2));
}