// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/admin/widgets/sellers.dart';
import 'package:shop_easy_ecommerce/features/admin/widgets/users.dart';

class AppUsersScreen extends StatefulWidget {
  const AppUsersScreen({super.key});

  @override
  State<AppUsersScreen> createState() => _AppUsersScreenState();
}

class _AppUsersScreenState extends State<AppUsersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool firstLoad = true;
  var tabs = const [
    Tab(
      text: 'Users',
    ),
    Tab(
      text: 'Sellers',
    )
  ];

  List<Widget> screens = const [Users(), Sellers()];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (firstLoad) {
      _tabController = TabController(length: tabs.length, vsync: this);

      firstLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TabBar(
                labelStyle: TextStyle(fontSize: 20.0),
                controller: _tabController,
                labelColor: GlobalVariables.selectedNavBarColor,
                unselectedLabelColor: GlobalVariables.unselectedNavBarColor,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: GlobalVariables.selectedNavBarColor,
                tabs: tabs,
              ),
            ),
            Container( height: deviceSize.height,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: screens),
            ),
          ],
        ),
      ),
    );
  }
}
