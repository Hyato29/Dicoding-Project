import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/restaurant_provider.dart';
import 'package:restaurant_v2/provider/search_restaurant_provider.dart';
import 'package:restaurant_v2/ui/about_screen.dart';
import 'package:restaurant_v2/ui/home_screen.dart';
import 'package:restaurant_v2/ui/restaurant_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  bool isSelected = false;

  Widget pages(int index) {
    switch (index) {
      case 0:
        return ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: const HomeScreen(),
        );
      case 1:
        return ChangeNotifierProvider<SearchRestaurantProvider>(
            create: (_) => SearchRestaurantProvider(apiService: ApiService()),
            child: const RestaurantScreen());
      case 2:
        return const AboutScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: Colors.amber,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: isSelected
                    ? const Icon(Icons.home_outlined)
                    : const Icon(Icons.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: isSelected
                    ? const Icon(Icons.favorite_outlined)
                    : const Icon(Icons.favorite),
                label: "Restaurant"),
            BottomNavigationBarItem(
                icon: isSelected
                    ? const Icon(Icons.info_outlined)
                    : const Icon(Icons.info),
                label: "Tentang"),
          ]),
    );
  }
}
