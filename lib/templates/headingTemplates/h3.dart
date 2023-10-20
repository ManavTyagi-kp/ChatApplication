import 'package:flutter/material.dart';

class Heading3 extends StatelessWidget {
  Heading3({
    this.size,
    this.fontWeight,
    this.color,
    this.overflow,
    required this.data,
    super.key,
  });
  var data;
  double? size;
  FontWeight? fontWeight;
  Color? color;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: size ?? 22,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? Colors.black,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
