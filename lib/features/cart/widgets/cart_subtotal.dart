// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/gradient_strip.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: GradientStrip(
          deviceSize: deviceSize,
          title: "Subtotal: ₹${sum} Only",
          imagePath: "assets/images/subtotal.png"),
    );
  }
}
