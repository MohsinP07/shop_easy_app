// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy_ecommerce/common/widgets/bottom_bar.dart';
import 'package:shop_easy_ecommerce/constants/error_handling.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/admin_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/login_screen.dart';
import 'package:shop_easy_ecommerce/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class AuthService {
  //sign up user

  void signUpUser({
    required BuildContext context,
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          phone: phone,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: [],
          wishlist: []);

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
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

  //sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            final user = Provider.of<UserProvider>(context, listen: false).user;
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            if (user.type == 'user') {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
            } else if (user.type == 'admin') {
              Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
            }
            // Navigator.pushNamedAndRemoveUntil(
            //     context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
