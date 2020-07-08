import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
      margin: me
          ? EdgeInsets.only(left: 100, right: 10, top: 10, bottom: 10)
          : EdgeInsets.only(left: 10, right: 100, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Material(
            child: Container(
              decoration: new BoxDecoration(
                color: me ? Colors.red[200] : Colors.green[200],
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment:
                    me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    from.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )),
                  Container(
                    child: Text(
                      message,
                      style: TextStyle(color: me ? Colors.white : Colors.black),
                    ),
                  )
                ],
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
