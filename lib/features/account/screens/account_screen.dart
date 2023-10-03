// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/account_button.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/below_app_bar.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/orders.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/profile.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/wishlist.dart';

enum AccountSettings { orders, profile, logout, wishlist }

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var _accountSettings = AccountSettings.orders;

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
            onPressed: () => AccountServices().logOut(context),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/se_logo.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  AccountButton(
                      text: "Your Orders",
                      onTap: () {
                        setState(() {
                          _accountSettings = AccountSettings.orders;
                        });
                      }),
                  AccountButton(
                      text: "Profile",
                      onTap: () {
                        setState(() {
                          _accountSettings = AccountSettings.profile;
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
                      text: "Log Out",
                      onTap: () {
                        logoutDialog(context);
                      }),
                  AccountButton(
                      text: "Your Wish List",
                      onTap: () {
                        setState(() {
                          _accountSettings = AccountSettings.wishlist;
                        });
                      })
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (_accountSettings == AccountSettings.orders) Orders(),
          if (_accountSettings == AccountSettings.profile) Profile(),
          if (_accountSettings == AccountSettings.wishlist) Wishlist(),
        ],
      ),
    );
  }
}
