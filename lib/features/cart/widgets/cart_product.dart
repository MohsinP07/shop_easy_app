// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/stars.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/cart/services/cart_services.dart';
import 'package:shop_easy_ecommerce/features/product_details/services/product_details_services.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.increaseQuantity(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    print(quantity);
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
                      child: product.quantity < 5 && product.quantity >= 1
                          ? Text(
                              'Only ${product.quantity.toInt()} left!',
                              style: TextStyle(color: Colors.amber),
                              maxLines: 2,
                            )
                          : product.quantity == 0
                              ? Text(
                                  'Out of Stock!!',
                                  style: TextStyle(color: Colors.red),
                                  maxLines: 2,
                                )
                              : Text(
                                  'In Stock',
                                  style: TextStyle(color: Colors.teal),
                                  maxLines: 2,
                                )),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border:
                              Border.all(color: Colors.black12, width: 1.5)),
                      child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(quantity.toString())),
                    ),
                    InkWell(
                      onTap: () {
                        if (quantity < product.quantity) {
                          increaseQuantity(product);
                        } else {
                          showSnackBar(context,
                              'Can\'t increase quantity, this product is out of stock!');
                        }
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
