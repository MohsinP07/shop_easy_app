// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/login_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/seller_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/user_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/landing/animation/FadeAnimation.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  showSignUpChoice(context) {
    AwesomeDialog(
        body: Container(
          width: MediaQuery.of(context).size.width * 60 / 100,
          height: MediaQuery.of(context).size.height * 26 / 100,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 60 / 100,
                height: MediaQuery.of(context).size.height * 18 / 100,
                child: Image.asset("assets/images/signup_choice.png"),
              ),
              Text(
                "Sign up as?",
                style: TextStyle(fontSize: 16),
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/se_logo.png',
                      width: 180,
                      height: 85,
                      color: Colors.black,
                    ),
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "Shop Easy, Shop Smart.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      )),
                ],
              ),
              FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Lottie.asset("assets/shimmers/landing.json"),
                  )),
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.6,
                      Container(
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
                            showSignUpChoice(context);
                          },
                          color: GlobalVariables.secondaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
