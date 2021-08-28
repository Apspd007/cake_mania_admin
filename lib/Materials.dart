import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData() {
  return ThemeData(
      backgroundColor: Color(0xFFEB96A7),
      primaryColor: Color(0xFFEB96A7),
      appBarTheme: AppBarTheme(
        color: Color(0xFFEB96A7),
      ),
      cardColor: Color(0xFFF9ED4E),
      scaffoldBackgroundColor: Color(0xFFEB96A7),
      accentColor: Color(0xFF73F8FC),
      canvasColor: Color(0xFFE8715F));
}

TextStyle textStyle({
  double? fontSize,
  Color? color,
  TextDecoration? textDecoration,
  bool enableShadow = true,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize == null ? 22.sp : fontSize.sp,
    color: color ?? Colors.white,
    decoration: textDecoration,
    fontWeight: fontWeight,
    shadows: enableShadow
        ? [
            Shadow(
                offset: Offset(0, 4.5), blurRadius: 4, color: Colors.black38),
          ]
        : null,
  );
}

class MyColorScheme {
  static Color englishVermillion = Color(0xFFC83F49);
  static Color corn = Color(0xFFF9ED4E);
  static Color terraCotta = Color(0xFFE8715E);
  static Color mauvelous = Color(0xFFEC98A8);
}
