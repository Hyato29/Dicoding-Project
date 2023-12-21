import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/provider/search_restaurant_provider.dart';
import 'package:restaurant_v2/ui/detail_screen.dart';
import 'package:restaurant_v2/utils/widgets/items_widget.dart';
import 'package:restaurant_v2/common/image_urls.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
        create: (context) => SearchRestaurantProvider(apiService: ApiService()),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Search Restaurant',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold, letterSpacing: 0.50),
                )),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      searchField(context),
                      const SizedBox(
                        height: 18,
                      ),
                      context.watch<SearchRestaurantProvider>().isLoading ==
                              true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : context
                                      .watch<SearchRestaurantProvider>()
                                      .searchRestauranResult
                                      .founded >
                                  0
                              ? onSearchRestaurant(context)
                              : context
                                          .watch<SearchRestaurantProvider>()
                                          .searchRestauranResult
                                          .founded ==
                                      0
                                  ? Center(
                                      child: Text(context
                                          .watch<SearchRestaurantProvider>()
                                          .message),
                                    )
                                  : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  TextField searchField(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        var query = searchController.text;
        Provider.of<SearchRestaurantProvider>(context, listen: false)
            .searchRestaurant(value = query);
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search Restaurant",
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder()),
      showCursor: true,
    );
  }

  SizedBox onSearchRestaurant(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Consumer<SearchRestaurantProvider>(
          builder: (context, value, child) {
            if (value.state == LoadingState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.state == LoadingState.loaded) {
              return restaurantItems(context);
            } else if (value.state == LoadingState.noData) {
              return Center(
                child: Text(value.message),
              );
            } else if (value.state == LoadingState.error) {
              return Center(
                child: Text(value.message),
              );
            }
            return const SizedBox();
          },
        ));
  }

  ListView restaurantItems(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      itemCount: context
          .watch<SearchRestaurantProvider>()
          .searchRestauranResult
          .founded,
      itemBuilder: (context, index) {
        var items = context
            .watch<SearchRestaurantProvider>()
            .searchRestauranResult
            .restaurants[index];
        return ItemsWidget(
          title: items.name,
          subTitle: items.city,
          rating: items.rating,
          urlImage: imgMedium + items.pictureId,
          heroTag: "detail-${items.pictureId}",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              String id = items.id;
              return ChangeNotifierProvider<RestaurantDetailProvider>(
                create: (_) =>
                    RestaurantDetailProvider(apiService: ApiService(), id: id),
                child: DetailScreen(id: id),
              );
            }));
          },
        );
      },
    );
  }
}
