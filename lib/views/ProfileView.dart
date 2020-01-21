
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/FirebaseStorage.dart';

class ProfileView extends StatefulWidget {
  User user;
  ProfileView({Key key, this.user}) : super(key : key);
  //ProfileView(User user)
  @override
  _ProfileView createState() => _ProfileView();

}

class _ProfileView extends State<ProfileView> {
  StorageReference _reference = FirebaseStorage.instance.ref().child('maria.png');

  Future<String> downloadImage() async {
    String _downloadUrl = await _reference.getDownloadURL();
    print(_downloadUrl);

    return _downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: FutureBuilder(
        future: downloadImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container (
              color: Color.fromRGBO(71, 67, 93, 1),
              child: SizedBox (
                height: 300,
                child: Column (
                  children: <Widget>[
                    SizedBox(height: 15),
                    Padding (
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            profilePicture(context, snapshot.data)
                          ],
                        )
                    ),
                    Text (
                      '${widget.user.name}  ${widget.user.firstSurname} ${widget.user.secondSurname}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(210, 206, 229, 1)
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget profilePicture(BuildContext context, String url)  {
    return CircleAvatar (
      backgroundColor: Color.fromRGBO(210, 206, 229, 1),
      radius: 70.0,
      backgroundImage: NetworkImage(url),
    );
  }





}