// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/wishlist_product.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

import 'single_product.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final AccountServices accountServices = AccountServices();

  void removeFromWishList(Product product) {
    accountServices.removeFromWishList(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Your Wishlist",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "View all",
                  style: TextStyle(color: GlobalVariables.selectedNavBarColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          SizedBox(
            height: 5,
          ),
          user.wishlist.isEmpty
              ? Text("Your wish list is empty!")
              : ListView.separated(
                  itemCount: user.wishlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return WishlistProduct(index: index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                )
        ],
      ),
    );
  }
}
