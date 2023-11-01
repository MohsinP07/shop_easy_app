// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/gradient_strip.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  void _showEditDialog() {
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;
    String newSellerName = seller.sellername;
    String newAddress = seller.address;
    String newPhone = seller.phone;

    final SellerService sellerServices = SellerService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: GradientStrip(
              deviceSize: MediaQuery.of(context).size,
              title: "Edit Profile",
              imagePath: "assets/images/edit_profile.png"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: newSellerName,
                  onChanged: (value) {
                    setState(() {
                      newSellerName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Seller Name'),
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
                sellerServices.updateSellerPersonalInformation(
                  context,
                  newSellerName,
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
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;
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
                  "Your Personal Details",
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
                  initialValue: seller.sellername,
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
                  initialValue: seller.address,
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
                  initialValue: seller.phone,
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
                TextFormField(
                  readOnly: true,
                  initialValue: seller.email,
                  decoration: InputDecoration(
                    label: Text("Email"),
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
