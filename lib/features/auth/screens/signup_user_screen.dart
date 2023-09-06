// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/common_val_textfield.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';

class SignUpUser extends StatefulWidget {
  static const String routename = '/signup-user-screen';
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
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
                "Create account",
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
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
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
