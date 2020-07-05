import 'package:NYOB/src/chatPage.dart';
import 'package:NYOB/src/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> getUser() async {
  return await _auth.currentUser();
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthStatus authStatus;

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      print(user);
      if (user.uid != null) {
        authStatus = AuthStatus.LOGGED_IN;
      }else if(user.uid == null){
        authStatus = AuthStatus.NOT_LOGGED_IN;
      }else{
        authStatus = AuthStatus.NOT_DETERMINED;
      }
    });
  }

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
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage();
        break;
      case AuthStatus.LOGGED_IN:
        return ChatPage();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
