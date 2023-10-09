// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

enum MenuOption { shopName, phone, address, name }

class ShopNameBox extends StatelessWidget {
  const ShopNameBox({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade300, Colors.teal.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '${seller.shopname} - ${seller.sellername}',
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )),
          PopupMenuButton(
            itemBuilder: (BuildContext ctx) {
              return <PopupMenuEntry<MenuOption>>[
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Shop name: ${seller.shopname}',
                          style: TextStyle(color: Colors.grey.shade700),

                          maxLines: 3, // Maximum lines for the text
                        ),
                      ),
                    ],
                  ),
                  value: MenuOption.shopName,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Name: ${seller.sellername}',
                          style: TextStyle(color: Colors.grey.shade700),

                          maxLines: 3, // Maximum lines for the text
                        ),
                      ),
                    ],
                  ),
                  value: MenuOption.shopName,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Address: ${seller.address}',
                          style: TextStyle(color: Colors.grey.shade700),

                          maxLines: 3, // Maximum lines for the text
                        ),
                      ),
                    ],
                  ),
                  value: MenuOption.shopName,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Phone: ${seller.phone}',
                          style: TextStyle(color: Colors.grey.shade700),
                          overflow:
                              TextOverflow.ellipsis, // Allow text to overflow
                          maxLines: 2, // Maximum lines for the text
                        ),
                      ),
                    ],
                  ),
                  value: MenuOption.phone,
                ),
              ];
            },
            icon: Icon(Icons.arrow_drop_down),
          )
        ],
      ),
    );
  }
}
