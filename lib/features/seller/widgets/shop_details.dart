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
    String newShopAddress = seller.shopAddress;
    String newShopLicenseNumber = seller.shopLicenseNumber;
    String newShopCategory = seller.shopCategory;
    String newShopOwnershipType = seller.shopOwnershipType;

    final SellerService sellerServices = SellerService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Shop Details'),
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
                  decoration: InputDecoration(labelText: 'Shop Name'),
                ),
                TextFormField(
                  initialValue: newShopAddress,
                  onChanged: (value) {
                    setState(() {
                      newShopAddress = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Shop Address'),
                ),
                TextFormField(
                  initialValue: newShopLicenseNumber,
                  onChanged: (value) {
                    setState(() {
                      newShopLicenseNumber = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Shop License Number'),
                ),
                TextFormField(
                  initialValue: newShopCategory,
                  onChanged: (value) {
                    setState(() {
                      newShopCategory = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Shop Category'),
                ),
                TextFormField(
                  initialValue: newShopOwnershipType,
                  onChanged: (value) {
                    setState(() {
                      newShopOwnershipType = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Shop Ownership Type'),
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
                  initialValue: seller.shopAddress,
                  decoration: InputDecoration(
                    label: Text("Shop Address"),
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
                  initialValue: seller.shopLicenseNumber,
                  decoration: InputDecoration(
                    label: Text("Shop License Number"),
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
                  initialValue: seller.shopCategory,
                  decoration: InputDecoration(
                    label: Text("Shop Category"),
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
                TextFormField(
                  readOnly: true,
                  initialValue: seller.shopOwnershipType,
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
