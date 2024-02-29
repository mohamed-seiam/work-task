import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle style13 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
    color: const Color(0xFF101010),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
  static TextStyle style10 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10.sp,
    color: const Color(0xFF757575),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
  static TextStyle style12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: const Color(0xFF888888),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
  static TextStyle style16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: const Color(0xFF101010),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}
