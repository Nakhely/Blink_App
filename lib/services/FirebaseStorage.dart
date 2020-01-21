
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

Future<String> getImageFromFirebaseStorage(BuildContext context, String urlImage) async {

  return await FirebaseStorage.instance.ref().child('default.png').getDownloadURL();
}