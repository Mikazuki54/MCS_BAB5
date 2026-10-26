import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle roboto14Italic = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle roboto14 = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle roboto14SemiBold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle roboto14Bold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static TextStyle roboto16Italic = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle roboto16 = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle roboto16SemiBold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle roboto16Bold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static TextStyle whiteRoboto14Bold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static Color mainColor = const Color(0xff36725D);
  static String loremIpsum = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String gambarThermometer = "thermometer.png";
  static String gambarSoilAnalysis = "soil_analysis.png";
  static String gambarSensorHumidity = "humidity_sensor.png";


}