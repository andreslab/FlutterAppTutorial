import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginPage(),
      routes: {
        "login": (context) => LoginPage(),
        "signup": (context) => SignUpPage()
      },
    );


  }


  
}