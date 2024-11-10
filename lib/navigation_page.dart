import 'package:flutter/material.dart';
import 'package:vendor_digital_canteen/orders/delivered_orders.dart';
import 'package:vendor_digital_canteen/orders/order_summary/order_summary_page.dart';
import 'package:vendor_digital_canteen/profile/profile_page.dart';
import 'package:vendor_digital_canteen/utils/constants/colors.dart';
import 'package:vendor_digital_canteen/views/menu/menu_page.dart';
import 'package:vendor_digital_canteen/views/orders/orders_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int myCurrentIndex = 0;

  final List<Widget> pages = [
    const OrdersPage(),
    OrderSummaryPage(),
    const DeliveredOrdersPage(),
    const MenuPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedItemColor: NColors.primary,
            unselectedItemColor: NColors.secondary,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dining_outlined),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Summary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining_rounded),
                label: 'Delivered',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      // Regular pages for Home and Profile
      body: pages[myCurrentIndex],
    );
  }
}
