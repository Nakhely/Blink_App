
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

Future<String> downloadImage(String reference) async {
  StorageReference _reference = FirebaseStorage.instance.ref().child(reference);
  String _downloadUrl = await _reference.getDownloadURL();
  print(_downloadUrl);

  return _downloadUrl;
}

Future uploadImageToFirebaseStorage (BuildContext context, String reference, File image) async {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();

  StorageReference storageReference = FirebaseStorage.instance.ref().child(reference);
  StorageUploadTask uploadTask = storageReference.putFile(image);
  await uploadTask.onComplete.then((result) => {
    _progressDialog.dismiss(),
    print('Succesful')
  });
}

ProgressDialog progressDialog (BuildContext context, ProgressDialogType progressDialogType, String message) {
  ProgressDialog progressDialog = ProgressDialog (context, type: progressDialogType);
  progressDialog.style(message: message);

  return progressDialog;
}