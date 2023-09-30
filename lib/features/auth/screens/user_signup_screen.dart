// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/login_screen.dart';
import 'package:shop_easy_ecommerce/features/landing/animation/FadeAnimation.dart';
import 'package:shop_easy_ecommerce/common/widgets/common_val_textfield.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';

class UserSignUpScreen extends StatefulWidget {
  static const String routeName = '/user-signup-screen';
  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final TextEditingController _confirmPasswordContoller =
      TextEditingController();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();

  bool hidePassword = true;

  final _signUpFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailContoller.text,
      phone: _phoneContoller.text,
      password: _passwordContoller.text,
      name: _nameContoller.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    _nameContoller.dispose();
    _phoneContoller.dispose();
    _confirmPasswordContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Form(
                key: _signUpFormKey,
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.3,
                      CommonValTextFormField(
                        controller: _nameContoller,
                        keyboardType: TextInputType.name,
                        label: "Name",
                        hintText: "Name",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your name";
                          } else if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(val)) {
                            return 'Please enter a valid name with letters and spaces only';
                          }
                          return null;
                        },
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      CommonValTextFormField(
                        controller: _phoneContoller,
                        keyboardType: TextInputType.phone,
                        label: "Phone",
                        hintText: "Phone",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your phone";
                          } else if (val.length < 10 || val.length > 10) {
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      CommonValTextFormField(
                        controller: _emailContoller,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email",
                        hintText: "Email",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      CommonValTextFormField(
                        controller: _passwordContoller,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        obscureText: hidePassword,
                        label: "Password",
                        hintText: "Password",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your password";
                          } else if (val.length < 6) {
                            return "Password must contain minuimum 6 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      CommonValTextFormField(
                        controller: _confirmPasswordContoller,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        label: "Confirm Password",
                        hintText: "Confirm Password",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please confirm your password";
                          } else if (val != _passwordContoller.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                  1.5,
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
                        if (_signUpFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )),
              FadeAnimation(
                  1.6,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginPage.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        Text(
                          " Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
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
