import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_v2/utils/background_service.dart';
import 'package:restaurant_v2/utils/date_time.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
 
  bool get isScheduled => _isScheduled;
 
  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      log('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}