
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentsView extends StatefulWidget {
  final String idPost;

  const CommentsView({Key key, this.idPost}) : super(key: key);

  @override
  _CommentsView createState() => _CommentsView();

}

class _CommentsView extends State<CommentsView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      appBar: AppBar (
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        title: Text ('Comments'),
      ),
      backgroundColor: Color.fromRGBO(71, 67, 93, 1),
      body: StreamBuilder (
        stream: Firestore.instance.collection('comments').where("idPost", isEqualTo: widget.idPost).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding (
                    padding: EdgeInsets.all(16),
                    child: Row (
                      children: <Widget>[
                        Text(snapshot.data.documents[index].data['text'].toString()),
                      ],
                    ),
                  );
                },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}