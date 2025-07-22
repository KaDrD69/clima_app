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
  // static final TextStyle textoGrande = GoogleFonts.roboto(
  //   color: Color(0xff2C3A47),
  //   fontSize: 200,
  //   fontWeight: FontWeight.normal,
  //   shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
  //   height: 1.0,
  // );
  static TextStyle textoGrande(BuildContext context) {
    // Calculamos tamaño proporcional según ancho de pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.4; // 40% del ancho

    // Limitamos tamaño mínimo y máximo para evitar que sea demasiado pequeño o grande
    fontSize = fontSize.clamp(80.0, 150.0);

    return GoogleFonts.roboto(
      color: Color(0xff2C3A47),
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
      height: 1.0,
    );
  }
  
  static final TextStyle textoPequeno1 = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 18,
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
  static final TextStyle textTarjetaGrande = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 1.0,
  );
  static final TextStyle textTarjetaPequeno1 = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.0,
  );
  static final TextStyle textoMinMax = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 22,
    fontWeight: FontWeight.bold,
    //shadows: [Shadow(offset: Offset(2, 2), color: Colors.black54, blurRadius: 3)],
    height: 1.0,
  );
  static final TextStyle textTarjetaPequeno2 = GoogleFonts.roboto(
    color: Color(0xff2C3A47),
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.0,
  );

  //questrial
  //inter
}
