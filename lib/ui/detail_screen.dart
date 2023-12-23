import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/db/database_helper.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/add_reviews_provider.dart';
import 'package:restaurant_v2/provider/database_provider.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/ui/add_reviews_screen.dart';
import 'package:restaurant_v2/ui/home_screen.dart';
import 'package:restaurant_v2/widgets/comment_widget.dart';
import 'package:restaurant_v2/widgets/foods_widget.dart';
import 'package:restaurant_v2/common/image_urls.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  DetailScreen({required this.id, super.key});

  String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = false;

  Future<void> reloadScreen() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 30), () {
      const CircularProgressIndicator();
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    reloadScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Consumer<RestaurantDetailProvider>(
                    builder: (context, value, child) {
                      if (value.state == LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.state == LoadingState.loaded) {
                        var items = value.restauranDetailResult;
                        return itemDetail(items, context);
                      } else if (value.state == LoadingState.noData) {
                        return Center(
                          child: Material(
                            child: Text(value.message),
                          ),
                        );
                      } else if (value.state == LoadingState.error) {
                        return Center(
                          child: Material(
                            child: Text(value.message),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  )))),
    );
  }

  Column itemDetail(RestaurantDetailModel items, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          child: cardRestaurant(context, items)),
      const SizedBox(
        height: 25,
      ),
      Text("Description",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10,
      ),
      Text(items.restaurant.description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(
        height: 25,
      ),
      Text("Foods",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: double.infinity,
        height: 80,
        child: itemFoods(items.restaurant),
      ),
      const SizedBox(
        height: 25,
      ),
      Text("Drinks",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: double.infinity,
        height: 80,
        child: itemDrinks(items.restaurant),
      ),
      const SizedBox(
        height: 25,
      ),
      Text("Comment",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 10,
      ),
      isLoading
          ? Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const CircularProgressIndicator(
                    color: Colors.amber,
                  )),
            )
          : ChangeNotifierProvider<AddReviewsProvider>(
              create: (context) => AddReviewsProvider(
                  apiService: ApiService(), id: items.restaurant.id),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.amber)),
                  child: Consumer<AddReviewsProvider>(
                    builder: (context, value, child) {
                      if (value.state == LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.state == LoadingState.loaded) {
                        return customerReviews(value);
                      } else if (value.state == LoadingState.error) {
                        return Center(
                            child: Material(child: Text(value.message)));
                      }
                      return const SizedBox();
                    },
                  )),
            ),
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) =>
                    ChangeNotifierProvider<AddReviewsProvider>(
                      create: (context) => AddReviewsProvider(
                          apiService: ApiService(), id: items.restaurant.id),
                      child: AddReviewsScreen(
                        id: items.restaurant.id,
                      ),
                    ));
            reloadScreen();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.amber),
          child: Text(
            "Add Comment",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    ]);
  }

  SizedBox cardRestaurant(BuildContext context, RestaurantDetailModel items) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Consumer<DatabaseProvider>(
          builder: (context, value, child) {
            return FutureBuilder<bool>(
              future: value.isFavorites(items.restaurant.id),
              builder: (context, snapshot) {
                var isFavorites = snapshot.data ?? false;
                return Stack(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                          tag: "detail-${items.restaurant.pictureId}",
                          child: Image.network(
                              imgMedium + items.restaurant.pictureId))),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            items.restaurant.name,
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
                                  "${items.restaurant.city} - ${items.restaurant.address}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                items.restaurant.rating.toString(),
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
                      child: isFavorites
                          ? FloatingActionButton(
                              backgroundColor: Colors.amber,
                              onPressed: () =>
                                  value.removeFavorites(items.restaurant.id),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          : FloatingActionButton(
                              backgroundColor: Colors.amber,
                              onPressed: () => value.addFavorites(items),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )
                ]);
              },
            );
          },
        ),
      ),
    );
  }

  ListView customerReviews(AddReviewsProvider value) {
    return ListView.builder(
      itemCount: value.restauranReviews.restaurant.customerReviews.length,
      itemBuilder: (context, index) {
        var review = value.restauranReviews.restaurant.customerReviews[index];
        return CommentWidget(
          title: review.name,
          subTitle: review.review,
          date: review.date.toString(),
        );
      },
    );
  }

  ListView itemDrinks(DetailRestaurant items) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = items.menus.drinks[index];
          return FoodsWidget(title: item.name);
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
        itemCount: items.menus.drinks.length);
  }

  ListView itemFoods(DetailRestaurant items) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = items.menus.foods[index];
          return FoodsWidget(title: item.name);
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
        itemCount: items.menus.foods.length);
  }
}
