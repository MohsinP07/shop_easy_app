// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/address/screens/address_screen.dart';
import 'package:shop_easy_ecommerce/features/cart/widgets/cart_product.dart';
import 'package:shop_easy_ecommerce/features/cart/widgets/cart_subtotal.dart';
import 'package:shop_easy_ecommerce/features/home/widgets/address_box.dart';
import 'package:shop_easy_ecommerce/features/search/screens/search_screen.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final cartItems = user.cart;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: EdgeInsets.only(left: 15, top: 12),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: 'Search ShopEasy.in',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            if (user.cart.isNotEmpty) CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: user.cart.isEmpty
                    ? "No items!"
                    : "Proceed to buy (${user.cart.length} items)",
                onTap: () {
                  if (user.cart.isEmpty) {
                    showSnackBar(context,
                        'Cart is empty, Please add items in cart to continue.');
                  } else {
                    navigateToAddressScreen(sum);
                  }
                },
                color: user.cart.isEmpty
                    ? Colors.grey.shade300
                    : Colors.yellow.shade600,
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            SizedBox(height: 5),
            Container(
              height: 200, // Set a fixed height for horizontal scrolling
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
            ),
            if (user.cart.isNotEmpty)
              const Text(
                "Scroll for more >>>",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: GlobalVariables.secondaryColor,
                    fontWeight: FontWeight.w200),
              )
          ],
        ),
      ),
    );
  }
}
