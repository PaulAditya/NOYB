import 'package:NYOB/src/messageBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final FirebaseUser user;
  ChatPage({Key key, this.user}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth oAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LET'S TALK"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Container(
              color: Color(0xFFFAFAFA),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("messages").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DocumentSnapshot> docs = snapshot.data.documents;

                    List<Widget> messages = docs
                        .map((e) => Message(
                              email: e.data["email"],
                              from: e.data["from"],
                              message: e.data["text"],
                              me: widget.user.email == e.data["email"],
                            ))
                        .toList();

                    return ListView(
                      controller: scrollController,
                      children: <Widget>[...messages],
                    );
                  }
                },
              ),
            )),

            //Bottom Container
            Container(
              color: Color(0xFFFAFAFA),
              child: Row(
                children: <Widget>[
                  Expanded(


                    //TextField
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                        ),
                        controller: messageController,
                      ),
                    ),
                  ),


                  //Send Icon
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      color: Color(0xFF00adb5),
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        if (messageController.text.trim().length > 0) {
                          await _firestore.collection("messages").add({
                            "text": messageController.text,
                            "from": widget.user.displayName,
                            "email": widget.user.email
                          });
                          messageController.clear();
                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 900),
                              curve: Curves.easeOutBack);
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
