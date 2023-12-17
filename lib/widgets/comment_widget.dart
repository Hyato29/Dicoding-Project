import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentWidget extends StatelessWidget {
  CommentWidget(
      {required this.title,
      required this.subTitle,
      required this.date,
      super.key});

  String title;
  String subTitle;
  String date;

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.amber),
                color: Color.fromARGB(random.nextInt(256), random.nextInt(255),
                    random.nextInt(255), random.nextInt(255)),
                shape: BoxShape.circle),
          ),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing: Text(date),
        ),
        const Divider()
      ],
    );
  }
}
