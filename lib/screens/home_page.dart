import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/screens/update_product_page.dart';
import 'package:storeapp/services/get_all_product_services.dart';
import 'package:storeapp/widget/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.cartPlus,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'New Trend',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 65),
        child: FutureBuilder<List<ProductModel>>(
            future: GetAllProducts().getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                products = snapshot.data!;
                return GridView.builder(
                    itemCount: products.length,
                    clipBehavior: Clip.none,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 100),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          print('Navigating to update page with product: ${products[index]}');
                          var result = await Navigator.pushNamed(
                            context,
                            UpdateProductPage.id,
                            arguments: products[index],
                          );
                          if (result != null) {
                            setState(() {
                              products[index] = result as ProductModel;
                            });
                          }
                        },
                        child: CustomCard(
                          product: products[index],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text('No data found'),
                );
              }
            }),
      ),
    );
  }
}
