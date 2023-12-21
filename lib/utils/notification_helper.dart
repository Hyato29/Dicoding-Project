import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';
import 'package:restaurant_v2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_v2/ui/detail_screen.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  Random random = Random();

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          dev.log('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var restaurantList = await ApiService().getRestaurant();
    var randomRestaurant = restaurantList
        .restaurants[random.nextInt(restaurantList.restaurants.length)];

    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "dicoding news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var titleNotification = "<b>${randomRestaurant.name}</b>";
    var titleRestaurant = randomRestaurant.description;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformChannelSpecifics,
      payload: json.encode(randomRestaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (context) => RestaurantDetailProvider(
                  apiService: ApiService(), id: data.id),
              child: DetailScreen(id: data.id));
        })));
      },
    );
  }
}
