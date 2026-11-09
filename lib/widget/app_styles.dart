import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle normalTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle boldTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle whiteBoldTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static Color mainColor = const Color(0xff36725D);
  static String loremIpsum = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String gambarThermometer = "thermometer.png";
  static String gambarSoilAnalysis = "soil_analysis.png";
  static String gambarSensorHumidity = "humidity_sensor.png";


}