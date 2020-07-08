import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Message extends StatelessWidget {
  final String from;
  final String message;
  final bool me;
  final String email;

  const Message({Key key, this.from, this.message, this.me, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.message == null) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(from),
          Material(
            color: me ? Colors.deepPurple[300] : Colors.limeAccent[200],
            borderRadius: BorderRadius.circular(13),
            child: Container(
              child: Text(
                message,
                style: TextStyle(color: me ? Colors.white : Colors.black),
              ),
              padding: EdgeInsets.all(10),
            ),
          )
        ],
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      ),
    );
  }
}
