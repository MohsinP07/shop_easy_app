// ignore_for_file: prefer_const_constructors

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
  String shopCategory = "Retail";
  List<String> shopCategories = [
    'Retail',
    'Wholesale',
    'Speciality Store',
    'Online Retailer',
    'Online Wholesaler',
  ];
  String ownership = "Proprietorship";
  List<String> ownershipTypes = [
    'Proprietorship',
    'Partnership',
    'One Person Company',
    'Corporate Company',
  ];
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(), // Add a third key for the third page
  ];

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
  final TextEditingController _shopaddressContoller = TextEditingController();
  final TextEditingController _shopLicenseNumberContoller =
      TextEditingController();
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
        CommonValTextFormField(
          controller: _shopaddressContoller,
          keyboardType: TextInputType.name,
          label: "Shop Address",
          hintText: "Shop Address",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your shop address";
            }
            return null;
          },
        ),
        CommonValTextFormField(
          controller: _shopLicenseNumberContoller,
          keyboardType: TextInputType.name,
          label: "Shop Licence Number",
          hintText: "Shop Licence Number",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your shop license number";
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: shopCategory,
            decoration: InputDecoration(
              labelText: 'Shop Category',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (String? newVal) {
              setState(() {
                shopCategory = newVal!;
              });
            },
            items: shopCategories.map((String item) {
              IconData icon;
              Color color;
        
              switch (item) {
                case 'Retail':
                  icon = Icons.shopping_bag;
                  color = Colors.blue;
                  break;
                case 'Wholesale':
                  icon = Icons.other_houses_outlined;
                  color = Colors.green;
                  break;
                case 'Speciality Store':
                  icon = Icons.folder_special_outlined;
                  color = Colors.orange;
                  break;
                case 'Online Retailer':
                  icon = Icons.integration_instructions_rounded;
                  color = Colors.blueGrey;
                  break;
                case 'Online Wholesaler':
                  icon = Icons.shopping_cart_checkout_outlined;
                  color = Colors.brown;
                  break;
                default:
                  icon = Icons.error;
                  color = Colors.red;
              }
        
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: [
                    Icon(icon, color: color),
                    SizedBox(width: 10),
                    Text(
                      item,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: ownership,
            decoration: InputDecoration(
              labelText: 'Shop Ownership Type',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (String? newVal) {
              setState(() {
                ownership = newVal!;
              });
            },
            items: ownershipTypes.map((String item) {
              IconData icon;
              Color color;
        
              switch (item) {
                case 'Proprietorship':
                  icon = Icons.person;
                  color = Colors.blue;
                  break;
                case 'Partnership':
                  icon = Icons.people;
                  color = Colors.green;
                  break;
                case 'One Person Company':
                  icon = Icons.person_2_rounded;
                  color = Colors.orange;
                  break;
                case 'Corporate Company':
                  icon = Icons.corporate_fare;
                  color = Colors.blueGrey;
                  break;
                default:
                  icon = Icons.error;
                  color = Colors.red;
              }
        
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: [
                    Icon(icon, color: color),
                    SizedBox(width: 10),
                    Text(
                      item,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
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
        shopAddress: _shopaddressContoller.text,
        shopLicenseNumber: _shopLicenseNumberContoller.text,
        shopCategory: shopCategory,
        shopOwnershipType: ownership,
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
      if (_formKeys[_currentPage].currentState!.validate()) {
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
      body: Column(
        children: [
          Column(
            children: <Widget>[
              FadeAnimation(
                  1,
                  Text(
                    "Sign up - Seller",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          Expanded(
            child: FadeAnimation(
              1.5,
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _formPages.asMap().entries.map((entry) {
                  final pageIndex = entry.key;
                  final page = entry.value;

                  return Form(
                    key: _formKeys.elementAt(
                        pageIndex), // Use elementAt to safely access the key
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        ...page,
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (pageIndex > 0)
                              // ElevatedButton(
                              //   onPressed: _previousPage,
                              //   child: Text("Previous"),
                              // ),
                              FadeAnimation(
                                  1.4,
                                  Container(
                                    width: 120,
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 46,
                                      onPressed: _previousPage,
                                      color: GlobalVariables.secondaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        "Previous",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  )),
                            if (_showSubmitButton)
                              // ElevatedButton(
                              //   onPressed: () {
                              //     if (_formKeys
                              //         .elementAt(pageIndex)
                              //         .currentState!
                              //         .validate()) {
                              //       signUpSeller();
                              //     }
                              //   },
                              //   child: Text("Submit"),
                              // ),
                              FadeAnimation(
                                  1.4,
                                  Container(
                                    width: 120,
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 46,
                                      onPressed: () {
                                        if (_formKeys
                                            .elementAt(pageIndex)
                                            .currentState!
                                            .validate()) {
                                          signUpSeller();
                                        }
                                      },
                                      color: GlobalVariables.secondaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  )),
                            if (pageIndex < _formPages.length - 1)
                              // ElevatedButton(
                              //   onPressed: _nextPage,
                              //   child: Text("Next"),
                              // ),
                              FadeAnimation(
                                  1.4,
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 46,
                                      onPressed: _nextPage,
                                      color: GlobalVariables.secondaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        "Next",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  )),
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
