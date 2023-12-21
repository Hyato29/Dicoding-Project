import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FoodsWidget extends StatelessWidget {
  FoodsWidget({required this.title, super.key});

  String title;

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          color: Color.fromARGB(random.nextInt(256), random.nextInt(255),
              random.nextInt(255), random.nextInt(255)),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
