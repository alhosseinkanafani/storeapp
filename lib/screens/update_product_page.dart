import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/services/update_product.dart';
import 'package:storeapp/widget/custom_button.dart';
import 'package:storeapp/widget/custom_text_field.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key});

  static String id = 'update';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? productName, desc, image, price;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    print('Arguments recieved: $args');
    if (args == null || args is! ProductModel) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid product data'),
        ),
      );
    }
    final ProductModel product = args;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  onChanged: (data) {
                    productName = data;
                  },
                  obscureText: false,
                  hintText: 'Product Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    desc = data;
                  },
                  obscureText: false,
                  hintText: 'description',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    price = data;
                  },
                  obscureText: false,
                  hintText: 'price',
                  inputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    image = data;
                  },
                  obscureText: false,
                  hintText: 'image',
                ),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Update',
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      ProductModel updatedProduct =
                          await updateProduct(product);
                      Navigator.pop(context, updatedProduct);
                      print('Success');
                    } catch (e) {
                      print(e.toString());
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    return await UpdateProductService().updateProduct(
        id: product.id,
        title: productName == null ? product.title : productName!,
        price: price == null ? product.price.toString() : price!,
        description: desc == null ? product.description : desc!,
        image: image == null ? product.image : image!,
        category: product.category);
  }
}
