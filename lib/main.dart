import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/navigation.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/database_provider.dart';
import 'package:restaurant_app2/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app2/provider/preferences_provider.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:restaurant_app2/provider/review_provider.dart';
import 'package:restaurant_app2/provider/scheduling_provider.dart';
import 'package:restaurant_app2/ui/detail_screen.dart';
import 'package:restaurant_app2/ui/home_screen.dart';
import 'package:restaurant_app2/ui/review_screen.dart';
import 'package:restaurant_app2/ui/search_screen.dart';
import 'package:restaurant_app2/ui/splash_screen.dart';
import 'package:restaurant_app2/utils/background_service.dart';
import 'package:restaurant_app2/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/styles.dart';
import 'data/db/database_helper.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ListenableProxyProvider<RestaurantProvider, DetailRestaurantProvider>(
          update: (_, restaurantProvider, detailRestaurantProvider) => DetailRestaurantProvider(apiService: ApiService(), id: restaurantProvider.id),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())
        ),
      ],
      child: MaterialApp(
        title: 'Lynx Resto',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            textTheme: myTextTheme,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: secondaryColor,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          DetailScreen.routeName: (context) => DetailScreen(),
          ReviewScreen.routeName: (context) => ReviewScreen(
            id: ModalRoute.of(context)?.settings.arguments as String,
          ),
          SearchScreen.routeName: (context) => SearchScreen()
        },
      ),
    );
  }
}
