import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  DataContainer({
    required this.child,
    required this.containerHeight,
    this.color,
    super.key,
  });

  Widget child;
  double containerHeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Container(
            height: containerHeight,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black),
              ],
              color: color ?? Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
