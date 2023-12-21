import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/provider/preferences_provider.dart';
import 'package:restaurant_v2/provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, child) {
                    return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyRestaurant(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
