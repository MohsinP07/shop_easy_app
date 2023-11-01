// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/gradient_strip.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int count = 0;

  void _showEditDialog() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    String newName = user.name;
    String newAddress = user.address;
    String newPhone = user.phone;

    final AccountServices accountServices = AccountServices();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: GradientStrip(
              deviceSize: MediaQuery.of(context).size,
              title: "Edit Profile",
              imagePath: "assets/images/edit_profile.png"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: newName,
                onChanged: (value) {
                  setState(() {
                    newName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                initialValue: newAddress,
                onChanged: (value) {
                  setState(() {
                    newAddress = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                initialValue: newPhone,
                onChanged: (value) {
                  setState(() {
                    newPhone = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call a function to send the updated information to backend
                accountServices.updateUserInformation(
                  context,
                  newName,
                  newAddress,
                  newPhone,
                );
                Navigator.pop(context);
                showSnackBar(context, "Updated!");
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Your Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showEditDialog();
                },
                child: Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    "Edit Profile",
                    style:
                        TextStyle(color: GlobalVariables.selectedNavBarColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: deviceSize.width * 86 / 100,
            padding: EdgeInsets.only(left: 10, right: 0, top: 20),
            child: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  initialValue: user.name,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: user.address,
                  decoration: InputDecoration(
                    label: Text("Address"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: user.phone,
                  decoration: InputDecoration(
                    label: Text("Phone"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter your Phone";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
