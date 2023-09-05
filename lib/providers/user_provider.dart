// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      phone: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: [],
      wishlist: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
