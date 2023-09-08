// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/models/seller.dart';

class SellerProvider extends ChangeNotifier {
  Seller _seller = Seller(
      id: '',
      sellername: '',
      shopname: '',
      phone: '',
      address: '',
      email: '',
      password: '',
      bankname: '',
      accountNumber: '',
      ifscCode: '',
      upiId: '',
      type: '',
      token: '');

  Seller get seller => _seller;

  void setSeller(String seller) {
    _seller = Seller.fromJson(seller);
    notifyListeners();
  }

  void setSellerFromModel(Seller seller) {
    _seller = seller;
    notifyListeners();
  }
}
