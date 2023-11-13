// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color color;
  final bool isUnderlined;
  final TextAlign textAlign;
  const RegularText({
    Key? key,
    required this.text,
    this.isUnderlined=false,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: fontSize,
          color: color,
          decoration:isUnderlined? TextDecoration.underline:null,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}
