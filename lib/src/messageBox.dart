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
    if (me) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(13),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF00adb5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(0, 2.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(message,
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: 12)),
              padding: EdgeInsets.all(10),
            ),
          )
        ], crossAxisAlignment: CrossAxisAlignment.end),
      );
    }
    
    
    
     else {
      return Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                from,
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 12),
              ),
            ),
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(0, 2.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
                padding: EdgeInsets.all(10),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }
}
