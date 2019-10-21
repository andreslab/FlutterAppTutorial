import 'package:chat_secreto/api/auth_api.dart';
import 'package:chat_secreto/widgets/circle.dart';
import 'package:chat_secreto/widgets/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  //key que se agrega al Form para acceder a funciones
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();

  var _username = '', _email = '', _password = '';

  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async{
    final isValid = _formKey.currentState.validate();
    if (isValid){
      //call request
      final isOk = await _authAPI.register(username : _username, email : _email, password: _password);
      if (isOk){
        print("REGISTER");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //captura el tamano de la pantalla
    final size = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          //cuando le da tap fuera del teclado
          FocusScope.of(context).requestFocus(FocusNode());
        },
              child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.25,
                top: -size.width * 0.36,
                child: Circle(
                  radius: size.width * 0.50,
                  colors: [Colors.pinkAccent, Colors.pinkAccent],
                ),
              ),
              Positioned(
                left: -size.width * 0.35,
                top: -size.width * 0.34,
                child: Circle(
                  radius: size.width * 0.40,
                  colors: [Colors.orange, Colors.deepOrange],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                width: 90,
                                height: 90,
                                margin: EdgeInsets.only(top: size.width * 0.3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 25)
                                    ])),
                            Text("Hello again. \nWelcome back",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: Form(
                                key: _formKey,
                                                              child: Column(children: <Widget>[
                                  InputText(label: "USERNAME",
                                  validator: (String text) {
                                    //solo acepta letras y numeros, validado con expresion regular
                                    if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text)) {
                                      _username = text;
                                      return null;
                                    }
                                    return "Invalid Username";
                                    },),
                                  SizedBox(height: 20,),
                                  InputText(label: "EMAIL ADDRESS",
                                  validator: (String text) {
                                    if (text.contains("@")) {
                                      _email = text;
                                      return null;
                                    }
                                    return "Invalid Email";
                                    },
                                    inputType: TextInputType.emailAddress,),
                                  SizedBox(height: 20,),
                                  InputText(label: "PASSWORD",
                                  validator: (String text) {
                                     if (text.isNotEmpty && text.length > 5) {
                                      _password = text;
                                      return null;
                                    }
                                    return "Invalid Password";
                                  },
                                  isSecure: true,)
                                ],),
                              )
                            ),
                            SizedBox(height: 40,),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: 17),
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(4),
                                onPressed: () => _submit(),
                                child: Text("Sign up",
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have a account",
                                style: TextStyle(fontSize: 16,
                                color: Colors.black54)),
                                CupertinoButton(
                                  child: Text("Sign in",
                                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
                                  onPressed: ()=>Navigator.pop(context),
                                )
                              ],
                            ),
                            SizedBox(height: size.height*0.03,)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
              ,Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                                  child: CupertinoButton(
                    onPressed: () =>Navigator.pop(context),
                    child: Icon(Icons.arrow_back,
                    color: Colors.white,),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30),
                    padding: EdgeInsets.all(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
