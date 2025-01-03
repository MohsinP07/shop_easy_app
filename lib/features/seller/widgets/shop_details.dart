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
    String shopCategory = "Retail";
    List<String> shopCategories = [
      'Retail',
      'Wholesale',
      'Speciality Store',
      'Online Retailer',
      'Online Wholesaler',
    ];
    String ownership = "Proprietorship";
    List<String> ownershipTypes = [
      'Proprietorship',
      'Partnership',
      'One Person Company',
      'Corporate Company',
    ];

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: shopCategory,
                    decoration: InputDecoration(
                      labelText: 'Shop Category',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (String? newVal) {
                      setState(() {
                        shopCategory = newVal!;
                        newShopCategory = shopCategory;
                      });
                    },
                    items: shopCategories.map((String item) {
                      IconData icon;
                      Color color;

                      switch (item) {
                        case 'Retail':
                          icon = Icons.shopping_bag;
                          color = Colors.blue;
                          break;
                        case 'Wholesale':
                          icon = Icons.other_houses_outlined;
                          color = Colors.green;
                          break;
                        case 'Speciality Store':
                          icon = Icons.folder_special_outlined;
                          color = Colors.orange;
                          break;
                        case 'Online Retailer':
                          icon = Icons.integration_instructions_rounded;
                          color = Colors.blueGrey;
                          break;
                        case 'Online Wholesaler':
                          icon = Icons.shopping_cart_checkout_outlined;
                          color = Colors.brown;
                          break;
                        default:
                          icon = Icons.error;
                          color = Colors.red;
                      }

                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          children: [
                            Icon(icon, color: color),
                            SizedBox(width: 10),
                            Text(
                              item,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: ownership,
                    decoration: InputDecoration(
                      labelText: 'Shop Ownership Type',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (String? newVal) {
                      setState(() {
                        ownership = newVal!;
                        newShopOwnershipType = ownership;
                      });
                    },
                    items: ownershipTypes.map((String item) {
                      IconData icon;
                      Color color;

                      switch (item) {
                        case 'Proprietorship':
                          icon = Icons.person;
                          color = Colors.blue;
                          break;
                        case 'Partnership':
                          icon = Icons.people;
                          color = Colors.green;
                          break;
                        case 'One Person Company':
                          icon = Icons.person_2_rounded;
                          color = Colors.orange;
                          break;
                        case 'Corporate Company':
                          icon = Icons.corporate_fare;
                          color = Colors.blueGrey;
                          break;
                        default:
                          icon = Icons.error;
                          color = Colors.red;
                      }

                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          children: [
                            Icon(icon, color: color),
                            SizedBox(width: 10),
                            Text(
                              item,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
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
                    context,
                    newShopName,
                    newShopAddress,
                    newShopLicenseNumber,
                    newShopCategory,
                    newShopOwnershipType);
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
