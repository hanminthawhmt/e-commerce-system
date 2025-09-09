import 'package:flutter/material.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/innder_header_widget.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/profile_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      InnerCategoryContentWidget(category: widget.category),
      FavoriteScreen(),
      CategoryScreen(),
      StoresScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
              print(pageIndex);
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
      body: pages[pageIndex],
    );
  }
}
