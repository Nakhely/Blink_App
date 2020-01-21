import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpashScreenView extends StatefulWidget {

  @override
  _SplashScreenView createState() => _SplashScreenView();
}

class _SplashScreenView extends State<SpashScreenView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(53, 50, 69, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding (
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: SizedBox(
                    width: media.width,
                    height: 200,
                    child: FlareActor('assets/blink.flr',
                      alignment: Alignment.center,
                      animation: 'blink',),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: emailField(context),
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: passwordField(context),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget emailField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(210, 206, 229, 1)
      ),
      decoration: decorationInput('Email', Icon(
        Icons.email,
        color: Color.fromRGBO(210, 206, 229, 1),
      ))
    );
  }

  Widget passwordField(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value.isEmpty){
          return 'Please enter some text';
        }
        return null;
      }
      ,obscureText: true,
      style: TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(210, 206, 229, 1)
      ),

      decoration: decorationInput('Password', Icon(
        Icons.lock,
        color: Color.fromRGBO(210, 206, 229, 1),
      )),
    );
  }

  InputDecoration decorationInput(String hintText, Icon icon) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color.fromRGBO(210, 206, 229, 1)
        ),
        prefixIcon: icon,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
        )
    );
  }

}