import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  Heading2({
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
        fontSize: size ?? 18,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? Colors.black,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
