import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppConstants {
  static const Color primaryColor = Colors.white;
  static const Color secondaryColor = Color.fromRGBO(255, 112, 41, 1);
  static const Color borderColor = Color.fromRGBO(255, 112, 41, 1);
  static const Color labelColor = Color.fromRGBO(121, 121, 121, 0.7);
  static const Color buttonColor = Color.fromRGBO(226, 91, 34, 1);
  static const Color textButtonColor = Colors.white;

  static TextStyle textField = GoogleFonts.almarai(
    fontSize: 16,
    color: labelColor
  );

  static TextStyle textButton = GoogleFonts.almarai(
    fontSize: 16,
    color: textButtonColor,
  );
  
  static TextStyle textHightlight = GoogleFonts.almarai(
    fontSize: 16,
    color: secondaryColor
  );

  static TextStyle contentPage = GoogleFonts.almarai(
    fontSize: 35,
    fontWeight: FontWeight.bold
  );
}