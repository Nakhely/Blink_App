
import 'package:Blink/models/User.dart';
import 'package:Blink/services/FirebaseStorage.dart';
import 'package:Blink/services/FirestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _message;
int _snapshopNumber;

class CommentsView extends StatefulWidget {
  final String idPost;
  final User userData;

  const CommentsView({Key key, this.idPost, this.userData}) : super(key: key);

  @override
  _CommentsView createState() => _CommentsView();

}

class _CommentsView extends State<CommentsView> {
  @override
  Widget build(BuildContext context) {
    var _media = MediaQuery.of(context).size;
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
      body: Column (
          children: <Widget>[
            Flexible (
              child: StreamBuilder (
                stream: Firestore.instance.collection('comments').where("idPost", isEqualTo: widget.idPost).orderBy('publish_date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    _snapshopNumber = snapshot.data.documents.length;
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding (
                          padding: EdgeInsets.all(16),
                          child: Row (
                            children: <Widget>[
                              Expanded (
                                child: Row (
                                  children: <Widget>[
                                    circleOtherUsersProfilePicture(context, snapshot.data.documents[index].data['circle_avatar']),

                                    Expanded (
                                      child: Padding (
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          snapshot.data.documents[index].data['name_user'].toString() + ' ' + snapshot.data.documents[index].data['text'].toString(),
                                          style: TextStyle (
                                              color: Colors.white
                                          ),
                                          maxLines: null,
                                        ),
                                      ) 
                                    )
                                  ],
                                ),
                              )

                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Not comments found'));
                  }
                },
              ),
            ),

            Row (
              children: <Widget>[
                Container (
                  width: _media.width,
                  color: Colors.white,
                  child: Row (
                    children: <Widget>[
                      FutureBuilder (
                        future: (widget.userData.hasProfile == true) ? downloadImage(widget.userData.id) : downloadImage('default.png'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding (
                              padding: EdgeInsets.all(8),
                              child: circleProfilePicture(context, snapshot.data),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      Expanded (
                        child: Padding (
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: inputPostMessage(context),
                        ),
                      ),

                      FutureBuilder (
                        future: (widget.userData.hasProfile == true) ? downloadImage(widget.userData.id) : downloadImage('default.png'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return sendPost(context, snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),

                    ],
                  ),
                )
              ],
            )
          ],
        ),
    );
  }

  Widget circleOtherUsersProfilePicture (BuildContext context, String url) {
    return CircleAvatar (
      backgroundColor: Color.fromRGBO(210, 206, 229, 1),
      radius: 20.0,
      backgroundImage: NetworkImage(url),
    );
  }

  Widget circleProfilePicture (BuildContext context, String url) {
    return CircleAvatar (
      backgroundColor: Color.fromRGBO(210, 206, 229, 1),
      radius: 20.0,
      backgroundImage: NetworkImage(url),
    );
  }

  Widget inputPostMessage (BuildContext context) {
    return TextFormField (
        onChanged: (value) => _message = value ,
        maxLines: null,
        style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(33, 33, 33, 1)
        ),
        decoration: decorationInput('What do you think?')

    );
  }

  InputDecoration decorationInput(String hintText) {
    return InputDecoration(
        hintText: hintText,

        hintStyle: TextStyle(
            color: Color.fromRGBO(33, 33, 33, 0.5)
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
        )
    );
  }

  Widget sendPost (BuildContext context, String urlImage) {
    return IconButton (
      iconSize: 25,
      icon: Icon (Icons.send, color: Color.fromRGBO(71, 67, 93, 1)),
      onPressed: () async {
        saveComments(widget.userData, context, _message, widget.idPost, urlImage, _snapshopNumber);
      },
    );
  }
}

