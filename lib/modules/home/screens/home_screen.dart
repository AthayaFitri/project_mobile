import 'package:flutter/material.dart';
import 'pages/clock_page.dart';
import 'pages/courses_page.dart';
import 'pages/home_page.dart';
import 'pages/money_page.dart';
import 'pages/notification_page.dart';
import 'pages/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> homeScreenPages = const <Widget>[
    HomePage(),
    CoursesPage(),
    MoneyChangerPage(),
    NotificationPage(),
    ClockPage(),
    ProfilePage(),
  ];

  static List<SalomonBottomBarItem> navBottomItem = <SalomonBottomBarItem>[
    SalomonBottomBarItem(
      icon: const Icon(Icons.home_rounded),
      title: const Text('Home'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.book_rounded),
      title: const Text('Courses'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.monetization_on_rounded),
      title: const Text('Money'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.notifications_rounded),
      title: const Text('Notif'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.access_time_filled_rounded),
      title: const Text('Clock'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person_rounded),
      title: const Text('Profile'),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenPages.elementAt(_selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) => onTapNav(index),
        items: navBottomItem,
      ),
    );
  }
}
