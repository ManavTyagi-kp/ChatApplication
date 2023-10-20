import 'package:flutter/material.dart';

class Chathead extends StatelessWidget {
  Chathead({
    required this.image,
    required this.name,
    required this.status,
    super.key,
  });

  Widget image;
  String name;
  String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: image,
            ),
            Column(
              children: [
                Text(name),
                Text(status),
              ],
            )
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Icon(Icons.search),
            ),
            TextButton(
              onPressed: () {},
              child: const Icon(Icons.more_vert),
            )
          ],
        )
      ],
    );
  }
}
