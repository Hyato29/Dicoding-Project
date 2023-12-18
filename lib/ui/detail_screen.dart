import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/add_reviews_provider.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/ui/add_reviews_screen.dart';
import 'package:restaurant_v2/widgets/comment_widget.dart';
import 'package:restaurant_v2/widgets/foods_widget.dart';
import 'package:restaurant_v2/common/image_urls.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  DetailScreen({required this.id, super.key});

  String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = false;

  Future<void> reload() async {
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
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            Navigator.pop(context);
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
                        var items = value.restauranDetailResult.restaurant;
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

  Column itemDetail(Restaurant items, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: 250,
          child: Hero(
            tag: "restaurant_${imgMedium + items.pictureId}",
            child: Image.network(
              imgMedium + items.pictureId,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      Text(
        items.name,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 255, 17, 0),
                size: 20,
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(items.city,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(items.address,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.star,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(items.rating.toString(),
              style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
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
      Text(items.description,
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
        child: itemFoods(items),
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
        child: itemDrinks(items),
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
              create: (context) =>
                  AddReviewsProvider(apiService: ApiService(), id: items.id),
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
                          apiService: ApiService(), id: items.id),
                      child: AddReviewsScreen(
                        id: items.id,
                      ),
                    ));
            reload();
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

  ListView itemDrinks(Restaurant items) {
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

  ListView itemFoods(Restaurant items) {
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
