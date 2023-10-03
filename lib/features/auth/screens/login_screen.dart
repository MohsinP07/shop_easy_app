// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/seller_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/user_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/landing/animation/FadeAnimation.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_seller_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_user_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';

enum LoginType { user, seller }

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final SellerService sellerService = SellerService();
  var _loginType = LoginType.user;
  bool hidePassword = true;

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

  showSignUpChoice(context) {
    AwesomeDialog(
        body: Container(
          width: MediaQuery.of(context).size.width * 60 / 100,
          height: MediaQuery.of(context).size.height * 24 / 100,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 60 / 100,
                height: MediaQuery.of(context).size.height * 18 / 100,
                child: Image.asset("assets/images/signup_choice.png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(UserSignUpScreen.routeName);
                      },
                      child: Text(
                        "User",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(SellerSignUpScreen.routename);
                      },
                      child: Text("Seller",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                ],
              )
            ],
          ),
        ),
        context: context,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 1.5 / 100),
        width: MediaQuery.of(context).size.width * 90 / 100,
        dialogType: DialogType.question,
        dialogBorderRadius: BorderRadius.circular(20),
        animType: AnimType.scale,
        btnCancel: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.red.shade300),
            )))
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: FadeAnimation(
          1,
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/se_logo.png',
              width: 120,
              height: 45,
              color: Colors.black,
            ),
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                      SizedBox(
                        height: 12,
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                            1.2,
                            CustomTextField(
                              controller: _emailContoller,
                              hintText: "Email",
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            CustomTextField(
                              obscureText: hidePassword,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              controller: _passwordContoller,
                              hintText: "Password",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              if (_signInFormKey.currentState!.validate()) {
                                if (_loginType == LoginType.user) {
                                  signInUser();
                                } else {
                                  signInSeller();
                                }
                              }
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          TextButton(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            onPressed: () {
                              showSignUpChoice(context);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
            FadeAnimation(
                1.2,
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Lottie.asset("assets/shimmers/login.json"),
                ))
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
