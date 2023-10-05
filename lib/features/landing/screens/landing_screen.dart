// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_easy_ecommerce/common/widgets/choice_chips.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/login_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/seller_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/user_signup_screen.dart';
import 'package:shop_easy_ecommerce/features/landing/animation/FadeAnimation.dart';

enum DialogChoice { userSeleced, sellerSelected }

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _dialogChoice = DialogChoice.userSeleced;
  showSignUpChoice(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_dialogChoice == DialogChoice.userSeleced) {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(UserSignUpScreen.routeName);
                    } else if (_dialogChoice == DialogChoice.sellerSelected) {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(SellerSignUpScreen.routename);
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w400),
                  ))
            ],
            content: Container(
              width: MediaQuery.of(context).size.width * 80 / 100,
              height: MediaQuery.of(context).size.height * 31 / 100,
              child: Column(
                children: [
                  Text(
                    "Create account as?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (_dialogChoice == DialogChoice.userSeleced)
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 60 / 100,
                          height: MediaQuery.of(context).size.height * 18 / 100,
                          child: Image.asset("assets/images/user_full.png"),
                        ),
                        Text(
                          "User",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  if (_dialogChoice == DialogChoice.sellerSelected)
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 60 / 100,
                          height: MediaQuery.of(context).size.height * 18 / 100,
                          child: Image.asset("assets/images/seller_chip.png"),
                        ),
                        Text(
                          "Seller",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonChoiceChips(
                          title: "User",
                          textColor: Colors.black,
                          selected: _dialogChoice == DialogChoice.userSeleced,
                          onSelected: (selected) {
                            setState(() {
                              _dialogChoice = selected
                                  ? DialogChoice.userSeleced
                                  : _dialogChoice;
                            });
                          },
                          toolTip: "Login as User",
                          image: "assets/images/user_chip.png"),
                      CommonChoiceChips(
                          title: "Seller",
                          textColor: Colors.black,
                          selected:
                              _dialogChoice == DialogChoice.sellerSelected,
                          onSelected: (selected) {
                            setState(() {
                              _dialogChoice = selected
                                  ? DialogChoice.sellerSelected
                                  : _dialogChoice;
                            });
                          },
                          toolTip: "Login as Seller",
                          image: "assets/images/seller_chip.png"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
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
