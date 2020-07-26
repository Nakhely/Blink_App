import 'package:Blink/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

void saveComments (User user, BuildContext context, String commentText, String idPost, String urlUserImage, int snapshotNumber) {
  ProgressDialog _progressDialog = progressDialog(context, ProgressDialogType.Normal, 'Please wait');
  _progressDialog.show();

  QuerySnapshot documents;
  String date = DateTime.now().toString();
  List<DocumentSnapshot> _myDocCount;

  Firestore.instance.collection('comments').document().setData({
    "circle_avatar" : urlUserImage,
    "idPost" : idPost,
    "name_user" : user.name + ' ' + user.firstSurname + ' ' + user.secondSurname,
    "text" : commentText,
    "publish_date" : date,

  }).then((result) async => {

    print('Succesfull'),
    documents = await Firestore.instance.collection('comments').getDocuments(),
    _myDocCount = documents.documents,
    Firestore.instance.collection('posts').document(idPost).updateData(
        {
      "comments" : FieldValue.arrayUnion([_myDocCount.length + 1])
        }
    ).then((result2) => {
      print('Succesfull 2'),
      _progressDialog.hide()
    })
  });
}

ProgressDialog progressDialog (BuildContext context, ProgressDialogType progressDialogType, String message) {
  ProgressDialog progressDialog = ProgressDialog (context, type: progressDialogType, isDismissible: true);
  progressDialog.style(message: message);

  return progressDialog;
}