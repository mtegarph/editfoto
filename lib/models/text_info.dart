import 'package:flutter/cupertino.dart';

class TextInfo {
  String text;
  double top;
  double left;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;
  
  TextInfo(
      {required this.text,
      required this.top,
      required this.left,
      required this.color,
      required this.fontWeight,
      required this.fontStyle,
      required this.fontSize,
      required this.textAlign});
}
