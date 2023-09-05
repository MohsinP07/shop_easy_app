// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy_ecommerce/constants/error_handling.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/admin/models/sales.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:shop_easy_ecommerce/models/order.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';
import 'package:http/http.dart' as http;

class SellerServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required String sellerId,
    required String sellerShopName,
    required List<File> images,
  }) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dvbm5rsyj', 'cyxvxbad');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price,
          sellerId: sellerId,
          sellerShopName: sellerShopName);

      http.Response res = await http.post(Uri.parse('$uri/seller/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-seller-token': sellerProvider.seller.token
          },
          body: product.toJson());
      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Succcessfully!!");
            Navigator.pop(context);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchMyProducts({required BuildContext context}) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/seller/products/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/seller/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/seller/get-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/seller/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
        body: jsonEncode({'id': order.id, 'status': status}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/seller/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-seller-token': sellerProvider.seller.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString('x-auth-seller-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routename, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
