import 'package:flutter/material.dart';
import 'package:storeapp/screens/home_page.dart';
import 'package:storeapp/screens/update_product_page.dart';

void main() {
  runApp(const Storeapp());
}
class Storeapp extends StatelessWidget {
  const Storeapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id : (context) => const HomePage(),
        UpdateProductPage.id : (context) => UpdateProductPage(),
      },
      initialRoute: HomePage.id,
    );
  }
}