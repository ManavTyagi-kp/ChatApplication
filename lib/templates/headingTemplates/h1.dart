import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  Heading1({
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
      maxLines: 2,
      style: TextStyle(
        fontSize: size ?? 50,
        fontWeight: fontWeight ?? FontWeight.w800,
        color: color ?? Colors.black,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
