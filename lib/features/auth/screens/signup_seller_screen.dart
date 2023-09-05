// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';

class SignUpSeller extends StatefulWidget {
  static const String routename = '/signup-seller-screen';
  const SignUpSeller({super.key});

  @override
  State<SignUpSeller> createState() => _SignUpSellerState();
}

class _SignUpSellerState extends State<SignUpSeller> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final TextEditingController _sellernameContoller = TextEditingController();
  final TextEditingController _shopnameContoller = TextEditingController();
  final TextEditingController _addressContoller = TextEditingController();
  final TextEditingController _banknameContoller = TextEditingController();
  final TextEditingController _accountNumberContoller = TextEditingController();
  final TextEditingController _bankConfirmAccountNumberContoller =
      TextEditingController();
  final TextEditingController _bankIfscContoller = TextEditingController();
  final TextEditingController _upiNumberContoller = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  final SellerService sellerService = SellerService();

  void signUpSeller() {
    sellerService.signUpSeller(
        context: context,
        sellername: _sellernameContoller.text,
        shopname: _shopnameContoller.text,
        phone: _phoneContoller.text,
        address: _addressContoller.text,
        email: _emailContoller.text,
        password: _passwordContoller.text,
        bankname: _banknameContoller.text,
        accountNumber: _accountNumberContoller.text,
        ifscCode: _bankIfscContoller.text,
        upiNumber: _upiNumberContoller.text);
    print(_sellernameContoller.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    _sellernameContoller.dispose();
    _phoneContoller.dispose();
    _shopnameContoller.dispose();
    _addressContoller.dispose();
    _banknameContoller.dispose();
    _accountNumberContoller.dispose();
    _bankConfirmAccountNumberContoller.dispose();
    _bankIfscContoller.dispose();
    _upiNumberContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/amazon_in.png',
              width: 120,
              height: 45,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Create account as seller",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _sellernameContoller,
                        hintText: "Seller Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _shopnameContoller,
                        hintText: "Shop Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _phoneContoller,
                        hintText: "Phone",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _addressContoller,
                        hintText: "Addess",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _emailContoller,
                        hintText: "Email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordContoller,
                        hintText: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      Text("Bank Details"),
                      CustomTextField(
                        controller: _banknameContoller,
                        hintText: "Bank Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _accountNumberContoller,
                        hintText: "Account Number",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _bankConfirmAccountNumberContoller,
                        hintText: "Confirm Account Number",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _bankIfscContoller,
                        hintText: "IFSC Code",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _upiNumberContoller,
                        hintText: "UPI Number",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpSeller();
                            }
                          })
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
