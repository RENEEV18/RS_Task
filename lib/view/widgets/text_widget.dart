import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.name,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.fontFamily,
    this.letterSpacing,
    this.textAlign,
    this.maxLines,
  });
  final String name;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? letterSpacing;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        overflow: overflow,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
