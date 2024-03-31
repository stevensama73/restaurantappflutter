import 'package:flutter/material.dart';
import 'package:restaurant_app2/ui/detail_screen.dart';
import 'package:restaurant_app2/ui/favorite_screen.dart';
import 'package:restaurant_app2/ui/restaurant_list_screen.dart';
import 'package:restaurant_app2/ui/settings_screen.dart';
import 'package:restaurant_app2/utils/notification_helper.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _bottomNavIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listWidget = [
    RestaurantListScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: 'Restaurant',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorite',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _notificationHelper.configureSelectNotificationSubject(DetailScreen.routeName, context);
    });
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
