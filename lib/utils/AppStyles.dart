import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'hexcolor.dart';

class AppStyles{
  static double iconHeight=10.0;
  static double gapWidth=8.0;
  static double gapHeight=10.0;
  static EdgeInsets screenPaddingH=const EdgeInsets.symmetric(horizontal: 15.0);
  static double iconPadding=18.0;
  static Color fadeGreenColor = HexColor.fromHex('#2a9d8f');
  static Color bgColor = HexColor.fromHex('#051213');
  static Color purpleColor = HexColor.fromHex('#5a189a');
  static Color fadePinkColor = HexColor.fromHex('#bc4749');
  static BorderRadiusGeometry  borderRadius =  BorderRadius.circular(12);
  static Color primaryColor =Colors.cyanAccent;
  static Color labelTxtColor =Colors.grey.shade600;
  static Color valueTxtColor =Colors.white;
  static Color loadingBoxColor =Colors.black12;
  static TextStyle contentTxtStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white);
  static TextStyle blackTxtStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.black);
  static TextStyle numTxtStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.w600,color: Colors.white);
  static TextStyle numTxtStyle1 = const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle greyTxtStyle = TextStyle(fontSize: 11,color: Colors.grey.shade500);
  static TextStyle greyTxtStyle1 = TextStyle(color: Colors.white70,fontSize: 11);
  static TextStyle labelTxtStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal);
  static TextStyle headingTxtStyle = const TextStyle( fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle headingTxtStyle1 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle buttonTxtStyle = const TextStyle(
    fontSize: 12,
  );
  static TextStyle underlineButtonTxtStyle = const TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
    fontSize: 12,
    color: Colors.white,
  );
  static TextStyle valueTextStyle = const TextStyle(fontSize: 13,
      fontWeight: FontWeight.w500);

}