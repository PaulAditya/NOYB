import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text,
    this.textSize, 
    this.fontWeight,{
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;
  final double textSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text,
          style:
              GoogleFonts.montserrat(color: Colors.white, fontSize: textSize, fontWeight: fontWeight)),
    );
  }
}
