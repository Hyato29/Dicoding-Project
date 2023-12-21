import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/db/database_helper.dart';
import 'package:restaurant_v2/provider/database_provider.dart';
import 'package:restaurant_v2/ui/about_screen.dart';
import 'package:restaurant_v2/ui/favorite_screen.dart';
import 'package:restaurant_v2/ui/home_screen.dart';
import 'package:restaurant_v2/ui/restaurant_screen.dart';
import 'package:restaurant_v2/ui/setting_screen.dart';
import 'package:restaurant_v2/utils/notification_helper.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  int currentIndex = 0;

  bool isSelected = false;

  Widget pages(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const RestaurantScreen();
      case 2:
        return ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
            child: const FavoriteScreen());
      case 3:
        return const SettingScreen();
      case 4:
        return const AboutScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages(currentIndex),
      bottomNavigationBar: navigationBar(),
    );
  }

  BottomNavigationBar navigationBar() {
    return BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.amber,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        items: navbarItems);
  }

  List<BottomNavigationBarItem> get navbarItems {
    return [
      BottomNavigationBarItem(
          icon: isSelected
              ? const Icon(Icons.home_outlined)
              : const Icon(Icons.home),
          label: "Home"),
      BottomNavigationBarItem(
          icon: isSelected
              ? const Icon(Icons.search_outlined)
              : const Icon(Icons.search),
          label: "Search"),
      BottomNavigationBarItem(
          icon: isSelected
              ? const Icon(Icons.favorite_outlined)
              : const Icon(Icons.favorite),
          label: "Restaurant"),
      BottomNavigationBarItem(
          icon: isSelected
              ? const Icon(Icons.settings_outlined)
              : const Icon(Icons.settings),
          label: "Restaurant"),
      BottomNavigationBarItem(
          icon: isSelected
              ? const Icon(Icons.info_outlined)
              : const Icon(Icons.info),
          label: "Tentang"),
    ];
  }
}
