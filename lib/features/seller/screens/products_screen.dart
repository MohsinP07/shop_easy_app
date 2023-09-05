// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/single_product.dart';
import 'package:shop_easy_ecommerce/features/seller/screens/seller_add_products_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/services/seller_services.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/shop_name_box.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final SellerServices sellerServices = SellerServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await sellerServices.fetchMyProducts(context: context);
    print(products);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    sellerServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, SellerAddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShopNameBox(),
            SizedBox(
              height: 5,
            ),
            products == null
                ? Loader()
                : SizedBox(
                    height: deviceSize.height,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: navigateToAddProduct,
        tooltip: "Add a Product",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
