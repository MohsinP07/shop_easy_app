import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/common_val_textfield.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/auth/services/auth_service.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';
import 'package:shop_easy_ecommerce/features/landing/animation/FadeAnimation.dart';

class SellerSignUpScreen extends StatefulWidget {
  static const String routename = '/seller-signup-screen';
  const SellerSignUpScreen({super.key});

  @override
  State<SellerSignUpScreen> createState() => _SellerSignUpScreenState();
}

class _SellerSignUpScreenState extends State<SellerSignUpScreen> {
  int _currentPage = 0;
  bool _showSubmitButton = false;
  bool hidePassword = true;
  final _signUpFormKey = GlobalKey<FormState>();
  final List<List<Widget>> _formPages = [];
  double _currentPageValue = 0.0;

  final SellerService sellerService = SellerService();

  PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final TextEditingController _confirmPasswordContoller =
      TextEditingController();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
    _formPages.addAll([
      [
        Text("Personal Details"),
        CommonValTextFormField(
          controller: _sellernameContoller,
          keyboardType: TextInputType.name,
          label: "Seller Name",
          hintText: "Seller Name",
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
          controller: _addressContoller,
          keyboardType: TextInputType.streetAddress,
          maxlines: 2,
          label: "Address",
          hintText: "Address",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your address";
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
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              )),
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
      ],
      [
        Text("Shop Details"),
        CommonValTextFormField(
          controller: _shopnameContoller,
          keyboardType: TextInputType.name,
          label: "Shop Name",
          hintText: "Shop Name",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your shop name";
            }
            return null;
          },
        ),
      ],
      [
        Text("Bank Details"),
        CommonValTextFormField(
          controller: _banknameContoller,
          keyboardType: TextInputType.name,
          label: "Bank Name",
          hintText: "Bank Name",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your bank name";
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        CommonValTextFormField(
          controller: _accountNumberContoller,
          keyboardType: TextInputType.text,
          label: "Account Number",
          hintText: "Account Number",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your account number";
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        CommonValTextFormField(
          controller: _bankConfirmAccountNumberContoller,
          obscureText: true,
          keyboardType: TextInputType.text,
          label: "Confirm Account Number",
          hintText: "Confirm Account Number",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please confirm your account number";
            } else if (val != _accountNumberContoller.text) {
              return "Account Number does not match";
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        CommonValTextFormField(
          controller: _bankIfscContoller,
          keyboardType: TextInputType.text,
          label: "IFSC Code",
          hintText: "IFSC Code",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your IFSC code";
            } else {
              // Remove any whitespace from the input
              val = val.replaceAll(RegExp(r'\s+'), '');

              // Check if the IFSC code consists of 11 characters
              if (val.length != 11) {
                return "IFSC code should have exactly 11 characters";
              }

              // Check if the first 4 characters are uppercase letters
              if (!RegExp(r'^[A-Z]{4}').hasMatch(val)) {
                return "First 4 characters should be uppercase letters";
              }

              // Check if the 5th character is '0'
              if (val[4] != '0') {
                return "5th character should be '0'";
              }

              // Check if the remaining characters are alphanumeric
              if (!RegExp(r'^[A-Za-z0-9]{6}$').hasMatch(val.substring(5, 11))) {
                return "Last 6 characters should be alphanumeric";
              }
            }
            return null; // IFSC code is valid
          },
        ),
        SizedBox(
          height: 10,
        ),
        CommonValTextFormField(
          controller: _upiNumberContoller,
          keyboardType: TextInputType.text,
          label: "UPI ID",
          hintText: "UPI ID",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your UPI ID";
            } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+$')
                .hasMatch(val)) {
              return 'Invalid UPI ID format';
            }
            return null;
          },
        ),
      ],
    ]);
  }

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
        upiId: _upiNumberContoller.text);
    print(_sellernameContoller.text);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    _confirmPasswordContoller.dispose();
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

  void _nextPage() {
    if (_currentPage < _formPages.length - 1) {
      setState(() {
        _currentPage++;
        if (_currentPage == _formPages.length - 1) {
          _showSubmitButton = true;
        }
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _showSubmitButton = false;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Seller"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FadeAnimation(
              1.5,
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _formPages.map((page) {
                  return Form(
                    key: _signUpFormKey,
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        ...page,
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currentPage > 0)
                              ElevatedButton(
                                onPressed: _previousPage,
                                child: Text("Previous"),
                              ),
                            if (_showSubmitButton)
                              ElevatedButton(
                                onPressed: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpSeller();
                                  }
                                },
                                child: Text("Submit"),
                              ),
                            if (_currentPage < _formPages.length - 1)
                              ElevatedButton(
                                onPressed: _nextPage,
                                child: Text("Next"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
