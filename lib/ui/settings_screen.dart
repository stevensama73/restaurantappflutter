import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/provider/preferences_provider.dart';
import 'package:restaurant_app2/provider/scheduling_provider.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Settings',
            style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
        ),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, _) {
          return ListView(
            children: [
              ListTile(
                title: Text('Scheduling Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyRestaurant(value);
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
