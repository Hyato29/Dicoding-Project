import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/common/image_urls.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/database_provider.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/ui/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Consumer<DatabaseProvider>(
          builder: (context, value, child) {
            if (value.state == LoadingState.loaded) {
              return ListView.builder(
                itemCount: value.favorites.length,
                itemBuilder: (context, index) {
                  var items = value.favorites[index].restaurant;
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        String id = items.id;
                        return ChangeNotifierProvider<RestaurantDetailProvider>(
                          create: (_) => RestaurantDetailProvider(
                              apiService: ApiService(), id: id),
                          child: DetailScreen(id: id),
                        );
                      }));
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.network(imgMedium + items.pictureId)),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.13,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    items.name,
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
                                      Expanded(
                                        child: Text(
                                          "${items.city} - ${items.address}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        items.rating.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                                color: Colors.amber),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.1,
                            right: MediaQuery.of(context).size.width * 0.05,
                            child: ClipOval(
                              child: Container(
                                color: Colors.amber,
                                child: IconButton(
                                  onPressed: () {
                                    value.removeFavorites(
                                        value.favorites[index].restaurant.id);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Material(
                  child: Text(value.message),
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
