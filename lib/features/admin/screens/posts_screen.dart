// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/single_product.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/add_products_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    print(products);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Total Products ( ${products!.length} )"),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: products!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (ctx, index) {
                        final productData = products![index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child:
                                  SingleProduct(image: productData.images[0]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),
                                IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData, index),
                                    icon: Icon(Icons.delete_outline))
                              ],
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: "Add a Product",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
