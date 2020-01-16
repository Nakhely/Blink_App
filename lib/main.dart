import 'package:flutter/material.dart';

import 'views/SpashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true, //Put False in production step
      home: SpashScreenView(),

      /* I need define routes for navigation of aplication */
      routes: <String, WidgetBuilder>{
        '/signin' : (BuildContext context) => null,
        '/signin/signup' : (BuildContext context) => null,
      },
    );
  }
}

