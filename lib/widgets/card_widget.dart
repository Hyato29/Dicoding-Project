import 'package:flutter/material.dart';
import 'package:restaurant_v2/common/image_urls.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget(
      {required this.items,
      required this.onTap,
      required this.heroTag,
      super.key});

  Restaurant items;
  Function() onTap;
  String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    imgMedium + items.pictureId,
                  ))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      items.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 0.20),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        items.rating.toString(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
