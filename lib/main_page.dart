import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
    _notificationHelper.configureSelectNotificationSubject(context);
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

  CurvedNavigationBar navigationBar() {
    return CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        color: Colors.amber,
        animationDuration: const Duration(milliseconds: 400),
        items: navbarItems);
  }

  List<Widget> get navbarItems {
    return const [
      Icon(Icons.home, color: Colors.white),
      Icon(Icons.search, color: Colors.white),
      Icon(Icons.favorite, color: Colors.white),
      Icon(Icons.settings, color: Colors.white),
      Icon(Icons.info, color: Colors.white),
    ];
  }
}
