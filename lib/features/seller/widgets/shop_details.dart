// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({super.key});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  void _showEditDialog() {
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;
    String newShopName = seller.shopname;

    final SellerService sellerServices = SellerService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Bank Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: newShopName,
                  onChanged: (value) {
                    setState(() {
                      newShopName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Bank Name'),
                ),
                // TextFormField(
                //   initialValue: newAccountNumber,
                //   onChanged: (value) {
                //     setState(() {
                //       newAccountNumber = value;
                //     });
                //   },
                //   decoration: InputDecoration(labelText: 'Account Number'),
                // ),
                // TextFormField(
                //   initialValue: newIfscCode,
                //   onChanged: (value) {
                //     setState(() {
                //       newIfscCode = value;
                //     });
                //   },
                //   decoration: InputDecoration(labelText: 'IFSC Code'),
                // ),
                // TextFormField(
                //   initialValue: newUpiNumber,
                //   onChanged: (value) {
                //     setState(() {
                //       newUpiNumber = value;
                //     });
                //   },
                //   decoration: InputDecoration(labelText: 'UPI Number'),
                // ),
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
                sellerServices.updateSellerShopInformation(
                    context, newShopName);
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
                  "Your Shop Details",
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
                    "Edit Details",
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
                  initialValue: seller.shopname,
                  decoration: InputDecoration(
                    label: Text("Shop Name"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter your shop name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  // initialValue: seller.accountNumber,
                  decoration: InputDecoration(
                    label: Text("Shop Info"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter shop info";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  // initialValue: seller.ifscCode,
                  decoration: InputDecoration(
                    label: Text("Shop Category"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter category";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  readOnly: true,
                  //  initialValue: seller.upiNumber,
                  decoration: InputDecoration(
                    label: Text("Ownership Type"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter type";
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
