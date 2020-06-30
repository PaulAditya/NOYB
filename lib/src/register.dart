import 'package:NYOB/src/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NYOB/util/firebase_auth.dart';

import 'gradientText.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  TextEditingController _emailController;
  TextEditingController _userNameController;
  TextEditingController _passwordController;
  TextEditingController _cnfrmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _userNameController = TextEditingController(text: "");
    _cnfrmPasswordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: <Widget>[
          //Login Text
          Container(
            height: 140,
            child: Center(
                child: GradientText(
              "Register",
              40,
              FontWeight.w900,
              gradient: LinearGradient(
                  colors: [Colors.indigo[900], Colors.blue[700]]),
            )),
          ),

          //Email

          Container(
              height: 60,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: TextField(
                
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),

          //Username
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              height: 60,
              child: TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),

          //Password
          Container(
              height: 60,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),

          //Confirm Password
          Container(
              height: 60,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: TextField(
                obscureText: true,
                controller: _cnfrmPasswordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),

          //Register Button

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                gradient: LinearGradient(
                    colors: [Colors.indigo[900], Colors.blue[700]])),
            child: MaterialButton(
              child: Text(
                "Register",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty ) {
                  //Email Password cannot be empty
                  print("Fields cannot be empty");
                  return;
                } else {
                  FirebaseUser user = await AuthFirebase().createUser(
                      _emailController.text,
                      _passwordController.text,
                      _userNameController.text);
                  if (!(user == null)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  user: user,
                                )));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Try Again"),
                    ));
                  }
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
