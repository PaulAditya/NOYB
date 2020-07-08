import 'package:NYOB/src/chatPage.dart';
import 'package:NYOB/src/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        FirebaseUser user = snapshot.data;
        if (snapshot.hasData) {
          print(user);
          return ChatPage(
            user: user,
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
