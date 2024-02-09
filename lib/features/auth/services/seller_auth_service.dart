// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy_ecommerce/common/widgets/bottom_bar.dart';
import 'package:shop_easy_ecommerce/constants/error_handling.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/login_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/screens/seller_screen.dart';
import 'package:shop_easy_ecommerce/models/seller.dart';
import 'package:http/http.dart' as http;
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';

class SellerService {
  //sign up seller

  void signUpSeller({
    required BuildContext context,
    required String sellername,
    required String shopname,
    required String shopAddress,
    required String shopLicenseNumber,
    required String shopCategory,
    required String shopOwnershipType,
    required String phone,
    required String address,
    required String email,
    required String password,
    required String bankname,
    required String accountNumber,
    required String ifscCode,
    required String upiId,
  }) async {
    try {
      Seller seller = Seller(
          id: '',
          sellername: sellername,
          shopname: shopname,
          shopAddress: shopAddress,
          shopLicenseNumber: shopLicenseNumber,
          shopCategory: shopCategory,
          shopOwnershipType: shopOwnershipType,
          phone: phone,
          address: address,
          email: email,
          password: password,
          bankname: bankname,
          accountNumber: accountNumber,
          ifscCode: ifscCode,
          upiId: upiId,
          type: '',
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/seller/signup'),
          body: seller.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(seller.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account has been created, you can Login now!");
            Navigator.of(context).pushNamed(LoginPage.routeName);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  //sign in seller
  void signInSeller({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/seller/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<SellerProvider>(context, listen: false)
                .setSeller(res.body);
            await prefs.setString(
                'x-auth-seller-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SellerScreen.routeName, (route) => false);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void updateSellerPersonalInformation(
      BuildContext context,
      String updatedSellerName,
      String updatedAddress,
      String updatedPhone) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);

    try {
      final res = await http.put(
        Uri.parse('$uri/seller/updateProfile'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
        body: jsonEncode({
          'seller': updatedSellerName,
          'address': updatedAddress,
          'phone': updatedPhone,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Seller updatedSeller = sellerProvider.seller.copyWith(
              sellername: updatedSellerName,
              address: updatedAddress,
              phone: updatedPhone,
            );
            sellerProvider.setSellerFromModel(updatedSeller);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateSellerBankInformation(
      BuildContext context,
      String updatedBankName,
      String updatedAccountNumber,
      String updatedIfsc,
      String updatedUpi) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);

    try {
      final res = await http.put(
        Uri.parse('$uri/seller/updateBankDetails'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
        body: jsonEncode({
          'bankname': updatedBankName,
          'accountNumber': updatedAccountNumber,
          'ifscCode': updatedIfsc,
          'upiNumber': updatedUpi,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Seller updatedSeller = sellerProvider.seller.copyWith(
                bankname: updatedBankName,
                accountNumber: updatedAccountNumber,
                ifscCode: updatedIfsc,
                upiNumber: updatedUpi);
            sellerProvider.setSellerFromModel(updatedSeller);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateSellerShopInformation(
    BuildContext context,
    String updatedShopName,
    String updatedShopAddress,
    String updatedShopLicenseNumber,
    String updatedShopCategory,
    String updatedShopOwnershipType,
  ) async {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);

    try {
      final res = await http.put(
        Uri.parse('$uri/seller/updateShopDetails'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-seller-token': sellerProvider.seller.token
        },
        body: jsonEncode({
          'shopname': updatedShopName,
          'shopAddress': updatedShopAddress,
          'shopLicenseNumber': updatedShopLicenseNumber,
          'shopCategory': updatedShopCategory,
          'shopOwnershipType': updatedShopOwnershipType
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Seller updatedSeller = sellerProvider.seller.copyWith(
                shopname: updatedShopName,
                shopAddress: updatedShopAddress,
                shopLicenseNumber: updatedShopLicenseNumber,
                shopCategory: updatedShopCategory,
                shopOwnershipType: updatedShopOwnershipType);
            sellerProvider.setSellerFromModel(updatedSeller);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get seller data
  void getSellerData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-seller-token");

      if (token == null) {
        prefs.setString("x-auth-seller-token", "");
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValidSeller'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-seller-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response sellerRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-seller-token': token
            });

        var sellerProvider =
            Provider.of<SellerProvider>(context, listen: false);
        sellerProvider.setSeller(sellerRes.body);
      }
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
