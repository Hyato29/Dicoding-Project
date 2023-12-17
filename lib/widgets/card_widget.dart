import 'package:flutter/material.dart';
import 'package:restaurant_v2/common/image_urls.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget({required this.restaurant, required this.onTap, super.key});

  Restaurant restaurant;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 241, 39),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  image: NetworkImage(imgMedium + restaurant.pictureId),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(restaurant.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
