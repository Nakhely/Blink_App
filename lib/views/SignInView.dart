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

            SizedBox(height: 40),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: passwordField(context),
                  )
                ],
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: signInButton(context),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: singUpButton(context),
                  )
                ],
              ),
            ),
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
      obscureText: true,
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

  Widget signInButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        print('usefull');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(210, 206, 229, 1),
      child: Text(
        'Enter',
        style: TextStyle(
          fontSize: 16
        ),
      ),
    );
  }

  Widget singUpButton(BuildContext context) {
    return FlatButton(
      onPressed: () {

      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
      ),

      child: Text(
        'Sign up',
        style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
        ),
      ),
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