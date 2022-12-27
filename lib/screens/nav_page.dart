import 'package:briskit/Screens/home_screen.dart';
import 'package:briskit/screens/favourite_screen.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavPageView extends StatefulWidget {
  static const routeName = 'nav-page';
  const NavPageView({Key? key}) : super(key: key);

  @override
  State<NavPageView> createState() => _NavPageViewState();
}

class _NavPageViewState extends State<NavPageView> {
  int _currentIndex = 0;
  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: _buildNotificationBadge(),
    );
  }
//Only Home and favourite screens are needed
  List<Widget> pages = const [
    HomeScreens(),
    FavouriteScreen(),
    HomeScreens(),
    HomeScreens(),
    HomeScreens(),
  ];

  Widget _buildNotificationBadge() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor:const Color(0xff040307),
      strokeColor:const Color(0x30040307),
      unSelectedColor:const Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon:const Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.explore),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.search),
        ),
        CustomNavigationBarItem(
          icon:const Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon:const Icon(Icons.notifications),
          badgeCount: _badgeCounts[4],
          showBadge: _badgeShows[4],
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _badgeShows[index] = false;
        });
      },
    );
  }
}
