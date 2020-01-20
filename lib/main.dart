import 'package:flutter/material.dart';
import 'package:flutter_app/views/SignUpView.dart';

import 'views/SignInView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true, //Put False in production step
      home: SignInView(),

      /* I need define routes for navigation of aplication */
      routes: <String, WidgetBuilder>{
        '/signup' : (BuildContext context) => SignUpView(),
      },
    );
  }
}

