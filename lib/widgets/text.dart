import 'package:flutter/material.dart';


class TextX extends StatelessWidget {
  const TextX(
      {Key? key,
      this.color,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.overflow,
      this.softWrap,
      this.style,
      this.maxLine,
      this.letterSpacing,
      this.textAlign,
      this.textDecoration,
      this.fontFamily})
      : super(key: key);

  final String? text;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final int? maxLine;
  final TextStyle? style;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      maxLines: maxLine,
      style: style ??
          TextStyle(
            color: color,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            decoration: textDecoration,
          ),
    );
  }
}
