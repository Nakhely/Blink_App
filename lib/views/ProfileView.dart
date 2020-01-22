
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Blink/models/User.dart';
import 'package:Blink/services/FirebaseStorage.dart';
import 'package:Blink/views/EditProfileView.dart';

class ProfileView extends StatefulWidget {
  final User user;
  ProfileView({Key key, this.user}) : super(key : key);

  @override
  _ProfileView createState() => _ProfileView();

}

class _ProfileView extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color.fromRGBO(71, 67, 93, 1),
      body: FutureBuilder(
        future: (widget.user.hasProfile != false) ? downloadImage(widget.user.id) : downloadImage('default.png'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container (
              child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding (
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            profilePicture(context, snapshot.data)
                          ],
                        )
                    ),
                    Padding (
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: AutoSizeText (
                        '${widget.user.name}  ${widget.user.firstSurname} ${widget.user.secondSurname}',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(210, 206, 229, 1)
                        ),
                        maxLines: 1,
                      ),
                    ),

                    Padding (
                      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 64),
                      child: Container (
                        width: double.infinity,
                        child: editProfile(context),
                      )
                    )
                  ],
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
      radius: 90.0,
      backgroundImage: NetworkImage(url),
    );
  }

  Widget editProfile (BuildContext context) {
    return RaisedButton (
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute (builder: (BuildContext context) => EditProfileView(user: widget.user)));
      },
      shape: RoundedRectangleBorder (
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(210, 206, 229, 1),
      child: AutoSizeText (
        'Edit profile',
        style: TextStyle (
          fontSize: 16
        ),
      ),
    );
  }





}