// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/product_details/services/product_details_services.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class WishlistProduct extends StatefulWidget {
  final int index;
  const WishlistProduct({super.key, required this.index});

  @override
  State<WishlistProduct> createState() => _WishlistProductState();
}

class _WishlistProductState extends State<WishlistProduct> {
  final AccountServices accountServices = AccountServices();
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void decreaseQuantity(Product product) {
    accountServices.removeFromWishList(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productWishlist =
        context.watch<UserProvider>().user.wishlist[widget.index];
    final product = Product.fromMap(productWishlist['product']);
    final quantity = productWishlist['quantity'];
    void addToCart() {
      productDetailsServices.addToCart(context: context, product: product);
    }

    print(product.quantity);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\₹${product.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Eligible for FREE Shipping"),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: CustomButton(
                      text: "Add to Cart!",
                      onTap: () => addToCart(),
                      color: Color.fromRGBO(254, 216, 19, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => decreaseQuantity(product),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => decreaseQuantity(product),
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      )),
                  Text(
                    "Remove from wishlist",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
