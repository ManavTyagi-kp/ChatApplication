import 'package:firebase_chat_app/templates/dataContainer.dart';
import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  PageTemplate(
      {this.dataContainerHeight,
      required this.headChild,
      required this.dataChild,
      this.color,
      super.key});

  Widget headChild;
  Widget dataChild;
  double? dataContainerHeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double containerHeight = dataContainerHeight ?? height - (height * 0.3);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(202, 205, 207, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(202, 205, 207, 1),
              ),
              child: headChild,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: containerHeight,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 244, 244, 245),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: DataContainer(
                containerHeight: dataContainerHeight ?? containerHeight,
                color: color,
                child: dataChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
