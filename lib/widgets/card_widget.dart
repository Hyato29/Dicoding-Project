import 'package:flutter/material.dart';
import 'package:restaurant_v2/common/image_urls.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget({required this.items, required this.onTap, required this.heroTag, super.key});

  Restaurant items;
  Function() onTap;
  String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: MediaQuery.of(context).size.width * 0.2,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 241, 39),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            ClipOval(
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    imgMedium + items.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(items.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
