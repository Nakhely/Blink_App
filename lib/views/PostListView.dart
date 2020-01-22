
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListView extends StatefulWidget {

  @override
  _PostListView createState() => _PostListView();
}

class _PostListView extends State<PostListView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold (
      appBar: AppBar (
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        automaticallyImplyLeading: false,
        title: Text ('Blink'),
      ),
      backgroundColor: Color.fromRGBO(71, 67, 93, 1),
      body: StreamBuilder (
        stream: Firestore.instance.collection('posts').orderBy('publish_date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding (
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Card(
                      color: Color.fromRGBO(210, 206, 229, 1),
                      child: new Column(
                        children: <Widget>[
                          Padding (
                            padding: EdgeInsets.all(16),
                            child: Row (
                              children: <Widget>[
                                Padding (
                                  padding: EdgeInsets.only(right: 18),
                                  child: profilePicture(context, snapshot.data.documents[index].data['circle_avatar'].toString()),
                                ),
                                Padding (
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: nameUser(context, snapshot.data.documents[index].data['name_user'].toString()),
                                )
                              ],
                            ),
                          ),

                          Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container (
                                height: 300,
                                width: media.width - 100,
                                decoration: BoxDecoration (
                                  image: DecorationImage(
                                      image: NetworkImage (snapshot.data.documents[index].data['url_image'].toString()),
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center
                                  ),
                                ),
                              )
                            ],
                          ),

                          Row (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding (
                                padding: EdgeInsets.all(16),
                                child: textMessage(
                                    context,
                                    snapshot.data.documents[index].data['name_user'].toString(),
                                    snapshot.data.documents[index].data['message'].toString()),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget nameUser(BuildContext context, String name) {
    return AutoSizeText(
      name,
      maxLines: 1,
      style: TextStyle (
        fontSize: 17
      ),
    );
  }

  Widget textMessage (BuildContext context, String name, String message) {
    return Text (
      name + ': ' + message,
      maxLines: 5,
      style: TextStyle (
        fontSize: 14
      ),
    );
  }

  Widget profilePicture(BuildContext context, String url)  {
    return CircleAvatar (
      backgroundColor: Color.fromRGBO(210, 206, 229, 1),
      radius: 25.0,
      backgroundImage: NetworkImage(url),
    );
  }


}