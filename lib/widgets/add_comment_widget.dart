import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddCommentWidget extends StatelessWidget {
  AddCommentWidget(
      {required this.titleCard,
      required this.controller,
      required this.maxLines,
      super.key});

  String titleCard;
  TextEditingController controller;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(titleCard, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              maxLines: maxLines,
              decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      fontFamily: "Poppins", color: Color(0xFF535050)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF959191))),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF959191)),
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 17)),
            )),
      ],
    );
  }
}
