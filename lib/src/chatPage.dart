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
        title: Text("CHAT"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
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
            ),

            //Text Field
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          hintText: "Yahan likh chodu",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90))),
                        ),
                        controller: messageController,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
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
