import 'package:NYOB/src/loginForm.dart';
import 'package:NYOB/src/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
                color: Colors.indigo[800],

                //Tabs
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text("Login"),
                      ),
                      Tab(
                        child: Text("SignUp"),
                      )
                    ],
                  ),
                ))),

        //Body
        body: TabBarView(
          children: <Widget>[
            //Login
            Container(padding: EdgeInsets.only(left:10, right:10),child: LoginForm()),

            //SignUp
           Container(padding: EdgeInsets.only(left:10, right:10),child: RegisterForm()),
          ],
        ),
      ),
    );
  }
}