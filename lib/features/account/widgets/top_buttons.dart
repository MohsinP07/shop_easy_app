// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () {}),
            AccountButton(text: "Profile", onTap: () {})
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: "Log Out",
                onTap: () => AccountServices().logOut(context)),
            AccountButton(text: "Your Wish List", onTap: () {})
          ],
        )
      ],
    );
  }
}
