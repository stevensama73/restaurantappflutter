import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/navigation.dart';

import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/provider/restaurant_provider.dart';
import 'package:rxdart/subjects.dart';


final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload ?? 'empty payload');
        });
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantResult restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurants channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var randomNumber = Random().nextInt(20);

    var titleNotification = "<b>Lynx</b>";
    var titleRestaurant = 'Mari Cek Restoran ${restaurant.restaurants[randomNumber].name}';

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode({"number": randomNumber, "data": restaurant.toJson()}));
  }

  void configureSelectNotificationSubject(String route, BuildContext context) {
    selectNotificationSubject.stream.listen((String payload) async {
        var data = RestaurantResult.fromJson(json.decode(payload)['data']);
        var restaurant = data.restaurants[json.decode(payload)['number']].id;
        Provider.of<RestaurantProvider>(context, listen: false).restaurantId = restaurant!;
        Navigation.intent(route);
      },
    );
  }
}