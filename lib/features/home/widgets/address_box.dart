// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

enum MenuOption { address, phone }

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
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
              "Delivery to ${user.name} - ${user.address}",
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
                          'Address: ${user.address}',
                          style: TextStyle(color: Colors.grey.shade700),

                          maxLines: 3, // Maximum lines for the text
                        ),
                      ),
                    ],
                  ),
                  value: MenuOption.address,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Phone: ${user.phone}',
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

          // Padding(
          //   padding: EdgeInsets.only(left: 5, top: 2),
          //   child: Icon(
          //     Icons.arrow_drop_down_outlined,
          //     size: 18,
          //   ),
          // )
        ],
      ),
    );
  }
}
