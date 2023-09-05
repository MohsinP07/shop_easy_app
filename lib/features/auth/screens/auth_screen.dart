// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_seller_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_user_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';

enum LoginType { user, seller }

class AuthScreen extends StatefulWidget {
  static const String routename = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final SellerService sellerService = SellerService();
  var _loginType = LoginType.user;

  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final TextEditingController _nameContoller = TextEditingController();

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailContoller.text,
      password: _passwordContoller.text,
    );
    print(_emailContoller.text);
  }

  void signInSeller() {
    sellerService.signInSeller(
        context: context,
        email: _emailContoller.text,
        password: _passwordContoller.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    _nameContoller.dispose();
  }

  showSignUpChoice() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Create account as?"),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel))
              ],
            ),
            content: Container(
              width: 120,
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpUser.routename);
                          },
                          child: Text(
                            "User",
                            style: TextStyle(fontSize: 16),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpSeller.routename);
                          },
                          child:
                              Text("Seller", style: TextStyle(fontSize: 16))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Please Login to continue",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: ChoiceChip(
                    label: Text("User"),
                    selected: _loginType == LoginType.user,
                    selectedColor: GlobalVariables.secondaryColor,
                    onSelected: (val) {
                      setState(() {
                        _loginType = LoginType.user;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ChoiceChip(
                    label: Text("Seller"),
                    selected: _loginType == LoginType.seller,
                    selectedColor: GlobalVariables.secondaryColor,
                    onSelected: (val) {
                      setState(() {
                        _loginType = LoginType.seller;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
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
                      CustomButton(
                          text: "Sign In",
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              if (_loginType == LoginType.user) {
                                signInUser();
                              } else {
                                signInSeller();
                              }
                            }
                          }),
                      TextButton(
                        onPressed: showSignUpChoice,
                        child: Text("Dont have an account. Create Account"),
                      )
                    ],
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
