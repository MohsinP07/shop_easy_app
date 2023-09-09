// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class SellerBelowAppBar extends StatelessWidget {
  const SellerBelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;

    return Container(
      decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  children: [
                TextSpan(
                  text: seller.sellername,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )
              ])),
        ],
      ),
    );
  }
}
