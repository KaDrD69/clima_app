import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstiloTextos {
  static final TextStyle titulo = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 25,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.0
    //shadows: [Shadow(offset: Offset(1, 1), color: Colors.black54, blurRadius: 3)],
  );
  static final TextStyle textoGrande = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 200,
    fontWeight: FontWeight.normal,
    shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
    height: 1.0,
  );
  static final TextStyle textoPequeno1 = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.0,
    //shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
    height: 1.0,
  );
  static final TextStyle textoPequeno2 = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.0,
  );
  static final TextStyle fecha = GoogleFonts.roboto(
    color: Colors.lightBlue.shade100,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.0,
  );

  //questrial
  //inter
}
