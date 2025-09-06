import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_app/views/sidebar_screens/buyers_screen.dart';
import 'package:web_app/views/sidebar_screens/category_screen.dart';
import 'package:web_app/views/sidebar_screens/orders_screen.dart';
import 'package:web_app/views/sidebar_screens/product_screen.dart';
import 'package:web_app/views/sidebar_screens/subcategory_screen.dart';
import 'package:web_app/views/sidebar_screens/upload_banner_screen.dart';
import 'package:web_app/views/sidebar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();
  void screenSelector(item) {
    switch (item.route) {
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;

      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;

      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;

      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;

      case SubCategoryScreen.id:
        setState(() {
          _selectedScreen = SubCategoryScreen();
        });

      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;

      case ProductScreen.id:
        setState(() {
          _selectedScreen = ProductScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(title: Text('Management'), backgroundColor: Colors.blue),
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Text(
              'Multi Store Admin',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
              ),
            ),
          ),
        ),
        items: [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrdersScreen.id,
            icon: Icons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Subcategories',
            route: SubCategoryScreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: UploadBannerScreen.id,
            icon: CupertinoIcons.add,
          ),
          AdminMenuItem(
            title: 'Product',
            route: ProductScreen.id,
            icon: Icons.shopping_cart,
          ),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
      body: _selectedScreen,
    );
  }
}
