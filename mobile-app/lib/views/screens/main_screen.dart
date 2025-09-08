import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/home_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/profile_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home.png',
                  width: 25,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/love.png',
                  width: 25,
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/mart.png',
                  width: 25,
                ),
                label: 'Stores'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/cart.png',
                  width: 25,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/user.png',
                  width: 25,
                ),
                label: 'Profile'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
