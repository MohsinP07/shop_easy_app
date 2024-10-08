// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/error_handling.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/models/user.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id!,
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
                cart: jsonDecode(res.body)[
                    'cart']); //only changing the cart parameter instead of whole class again

            userProvider.setUserFromModel(user);
            showSnackBar(context, "Added to cart!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void buyNow({required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/buy-now'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id!,
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
                cart: jsonDecode(res.body)[
                    'cart']); //only changing the cart parameter instead of whole class again

            userProvider.setUserFromModel(user);
            showSnackBar(context,
                "Confirm address and select payment method the details!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void increaseQuantity(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/increase-quantity'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'id': product.id!,
              }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
                cart: jsonDecode(res.body)[
                    'cart']); //only changing the cart parameter instead of whole class again

            userProvider.setUserFromModel(user);
            showSnackBar(context, "Quantity increased!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToWishlist(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-wishlist'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id!,
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
                wishlist: jsonDecode(res.body)[
                    'wishlist']); //only changing the cart parameter instead of whole class again

            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Added to wishlist');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id!, 'rating': rating}));

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
