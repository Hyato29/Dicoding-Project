import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemsWidget extends StatelessWidget {
  ItemsWidget(
      {required this.urlImage,
      required this.title,
      required this.subTitle,
      required this.rating,
      required this.heroTag,
      required this.onTap,
      super.key});

  String urlImage;
  String title;
  String subTitle;
  double rating;
  String heroTag;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(tag: heroTag, child: Image.network(urlImage))),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          subTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  letterSpacing: 1),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
