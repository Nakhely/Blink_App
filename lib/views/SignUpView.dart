
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Blink/models/User.dart';
import 'package:Blink/services/FirebaseAuthentication.dart';

String _name, _firstSurname, _secondSurname, _email, _password;

class SignUpView extends StatefulWidget {

  @override
  _SignUpView createState() => _SignUpView();
}

class _SignUpView extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(53, 50, 69, 1),
        title: Text('Create your account'),
      ),
      backgroundColor: Color.fromRGBO(66, 62, 83, 1),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Personal information',
              style: TextStyle(
                color: Color.fromRGBO(210, 206, 229, 1),
                fontSize: 16
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: nameField(context, 'Name', 'Your name')
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: firstSurnameField(context, 'First surname', 'Your first surname')
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: secondSurnameField(context, 'Second surname', 'Your second surname'),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Authentication information',
              style: TextStyle(
                  color: Color.fromRGBO(210, 206, 229, 1),
                  fontSize: 16
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: emailField(context, 'Email', 'Your email'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: passwordField(context, 'Password', 'Your password'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: registerButton(context),
          )
        ],
      ),

    );
  }

  Widget nameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => _name = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
    );
  }

  Widget firstSurnameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => _firstSurname = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
    );
  }

  Widget secondSurnameField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      onChanged: (value) => _secondSurname = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
    );
  }

  Widget emailField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => _email = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
    );
  }

  Widget passwordField(BuildContext context, String labelName, String hintText) {
    return TextFormField (
      obscureText: true,
      onChanged: (value) => _password = value,
      decoration: decorationInput(labelName, hintText),
      style: TextStyle(
          color: Color.fromRGBO(210, 206, 229, 1),
          fontSize: 16
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        registerUser(User('', _name, _firstSurname, _secondSurname, false), context, _email, _password);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(210, 206, 229, 1),
      child: Text(
        'Register',
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

  InputDecoration decorationInput(String labelName, String hintText) {
    return InputDecoration (
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color.fromRGBO(210, 206, 229, 1)
      ),

      labelText: labelName,
      labelStyle: TextStyle(
        color: Color.fromRGBO(210, 206, 229, 1)
      ),

      enabledBorder: OutlineInputBorder (
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
      ),

      focusedBorder: OutlineInputBorder (
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color.fromRGBO(210, 206, 229, 1))
      )
    );
  }

}