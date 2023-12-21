import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/common/navigation.dart';
import 'package:restaurant_v2/common/text_theme.dart';
import 'package:restaurant_v2/data/preferences/preferences_helper.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/main_page.dart';
import 'package:restaurant_v2/provider/preferences_provider.dart';
import 'package:restaurant_v2/provider/restaurant_provider.dart';
import 'package:restaurant_v2/provider/scheduling_provider.dart';
import 'package:restaurant_v2/provider/search_restaurant_provider.dart';
import 'package:restaurant_v2/ui/detail_screen.dart';
import 'package:restaurant_v2/ui/home_screen.dart';
import 'package:restaurant_v2/ui/restaurant_screen.dart';
import 'package:restaurant_v2/ui/setting_screen.dart';
import 'package:restaurant_v2/ui/splash_screen.dart';
import 'package:restaurant_v2/utils/background_service.dart';
import 'package:restaurant_v2/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: const HomeScreen(),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
            create: (_) => SearchRestaurantProvider(apiService: ApiService()),
            child: const RestaurantScreen()),
        ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(), child: const SettingScreen()),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
          child: const SettingScreen(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restauran App',
        theme: ThemeData(
          textTheme: myTextTheme,
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          MainPage.routeName: (context) => const MainPage(),
          DetailScreen.routeName: (context) => DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
