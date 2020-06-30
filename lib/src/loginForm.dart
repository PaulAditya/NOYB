import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NYOB/util/firebase_auth.dart';

import 'chatPage.dart';
import 'gradientText.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
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
              "Welcome",
              40,
              FontWeight.w900,
              gradient: LinearGradient(
                  colors: [Colors.indigo[900], Colors.blue[700]]),
            )),
          ),

          //Username
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              height: 60,
              child: TextField(
                controller: _emailController,
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

          //Login Button

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
                "Login",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  //Email Password cannot be empty
                  print("Email and password cannot be empty");
                  return;
                } else {
                  FirebaseUser user = await AuthFirebase().signInWithEmail(
                      _emailController.text, _passwordController.text);
                  if (user!=null) {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  user: user,
                                )));
                    //Home page
                  } else {
                    print("Login Failed");
                    return;
                  }
                }
              },
            ),
          ),

          //"OR"
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 20,
                      )),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.montserrat(),
                ),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 20,
                      )),
                ),
              ],
            ),
          ),

          //Other Logins
          // Container(
          //   margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: <Widget>[
          //       Expanded(
          //           child: RawMaterialButton(
          //               onPressed: () async {
          //                 FirebaseUser user =
          //                     await AuthFirebase().signInWithGoogle();
          //                 print("Google User $user");
          //               },
          //               padding: EdgeInsets.all(10),
          //               shape: RoundedRectangleBorder(),
          //               fillColor: Colors.white,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: <Widget>[
          //                   Container(
          //                       margin: EdgeInsets.only(right: 10),
          //                       child: Icon(
          //                         CustomIconBtn.gplus,
          //                         color: Colors.red,
          //                         size: 25,
          //                       )),
          //                   Container(
          //                       child: Text(
          //                     "Sign in with Google",
          //                     style: GoogleFonts.montserrat(),
          //                   ))
          //                 ],
          //               )))
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}
