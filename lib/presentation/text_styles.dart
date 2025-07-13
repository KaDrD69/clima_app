import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstiloTextos {
  static final TextStyle titulo = GoogleFonts.inter(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(offset: Offset(1, 1), color: Colors.black54, blurRadius: 3)],
  );
  static final TextStyle textoGrande = GoogleFonts.inter(
    color: Colors.white,
    fontSize: 80,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
    height: 1.0,
  );
  static final TextStyle textoPequeno1 = GoogleFonts.inter(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
    height: 1.0,
  );
  static final TextStyle textoPequeno2 = GoogleFonts.inter(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.0,
  );

  //questrial
  //inter
}
