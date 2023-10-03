// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/account_button.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/below_app_bar.dart';
import 'package:shop_easy_ecommerce/features/seller/services/seller_services.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/bank_details.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/personal_details.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/seller_below_app.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/shop_details.dart';

enum ProfileTypes { personalDetails, bankDetails, logout, shopDetails }

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerPofileScreenState();
}

class _SellerPofileScreenState extends State<SellerProfileScreen> {
  var _accountSettings = ProfileTypes.personalDetails;

  logoutDialog(context) {
    AwesomeDialog(
        body: Container(
            width: MediaQuery.of(context).size.width * 60 / 100,
            height: MediaQuery.of(context).size.height * 24 / 100,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 60 / 100,
                  height: MediaQuery.of(context).size.height * 18 / 100,
                  child: Image.asset("assets/images/logout.png"),
                ),
                Center(
                  child: Text("Are you sure you want to logout?"),
                ),
              ],
            )),
        context: context,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 1.5 / 100),
        width: MediaQuery.of(context).size.width * 90 / 100,
        dialogType: DialogType.question,
        dialogBorderRadius: BorderRadius.circular(20),
        animType: AnimType.scale,
        btnOk: TextButton(
            onPressed: () => SellerServices().logOut(context),
            child: Text("Logout")),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SellerBelowAppBar(),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    AccountButton(
                        text: "Personal Details",
                        onTap: () {
                          setState(() {
                            _accountSettings = ProfileTypes.personalDetails;
                          });
                        }),
                    AccountButton(
                        text: "Bank Details",
                        onTap: () {
                          setState(() {
                            _accountSettings = ProfileTypes.bankDetails;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AccountButton(
                        text: "Shop Details",
                        onTap: () {
                          setState(() {
                            _accountSettings = ProfileTypes.shopDetails;
                          });
                        }),
                    AccountButton(
                        text: "Log Out",
                        onTap: () {
                          logoutDialog(context);
                        }),
                  ],
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            if (_accountSettings == ProfileTypes.personalDetails)
              PersonalDetails(),
            if (_accountSettings == ProfileTypes.bankDetails) BankDetails(),
            if (_accountSettings == ProfileTypes.shopDetails) ShopDetails(),
          ],
        ),
      ),
    );
  }
}
