// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/analtycs_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/app_users_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/orders_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/posts_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-home';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    PostsScreen(),
    AnalticsScreen(),
    OrdersScreen(),
    AppUsersScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

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
            onPressed: () => AdminServices().logOut(context),
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
      body: pages[_page],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    logoutDialog(context);
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //POSTS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: Icon(Icons.home_outlined),
              ),
              label: ""),
          //ANALYTICS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: Icon(Icons.analytics_outlined),
              ),
              label: ''),
          //ORDERS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: Icon(Icons.all_inbox_outlined),
              ),
              label: ''),
          //APP USERS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 3
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: Icon(Icons.supervised_user_circle_sharp),
              ),
              label: ''),
        ],
      ),
    );
  }
}
