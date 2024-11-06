import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendor_digital_canteen/orders/new_order_page.dart';
import 'firebase_options.dart';
import 'orders/global_orders_page.dart'; // Import the generated firebase_options.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Firebase is initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use platform-specific Firebase options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  NewOrderPage(),
    );
  }
}


