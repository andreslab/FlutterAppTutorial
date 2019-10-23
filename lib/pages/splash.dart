import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/session.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  final _session = Session();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.check();
  }

  check() async {
    final data = await _session.get();
    if(data != null) {
      //reemplaza la pantalla actual por la de destino
      Navigator.pushReplacementNamed(context, "home");
    }else{
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 15,),
      ),
    );
  }
}