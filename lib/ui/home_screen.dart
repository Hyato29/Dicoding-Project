import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/provider/restaurant_provider.dart';
import 'package:restaurant_v2/ui/detail_screen.dart';
import 'package:restaurant_v2/widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            'Restaurant App',
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommendation Restaurant for You !",
                maxLines: 2,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: const Image(
                      image: AssetImage("assets/imgs/splash_image.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Recommendation",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Consumer<RestaurantProvider>(
                    builder: (context, value, child) {
                      if (value.state == LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.state == LoadingState.loaded) {
                        return cardItem(value, 8, "recommendation");
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
                  )),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Popular",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Consumer<RestaurantProvider>(
                    builder: (context, value, child) {
                      if (value.state == LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.state == LoadingState.loaded) {
                        return cardItem(value, 5, "popular");
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
                  ))
            ],
          ),
        ),
      )),
    );
  }

  ListView cardItem(RestaurantProvider value, int itemCount, String tag) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(
        width: 12,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var items = value.restauranResult.restaurants[index];
        String heroTag = "$tag${items.pictureId}";
        return CardWidget(
            items: items,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                String id = items.id;
                return ChangeNotifierProvider<RestaurantDetailProvider>(
                  create: (_) => RestaurantDetailProvider(
                      apiService: ApiService(), id: id),
                  child: DetailScreen(id: id),
                );
              }));
            },
            heroTag: heroTag,);
      },
    );
  }
}
