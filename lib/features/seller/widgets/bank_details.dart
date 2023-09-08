// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/auth/services/seller_auth_service.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  void _showEditDialog() {
    final seller = Provider.of<SellerProvider>(context, listen: false).seller;
    String newBankName = seller.bankname;
    String newAccountNumber = seller.accountNumber;
    String newIfscCode = seller.ifscCode;
    String newUpiNumber = seller.upiId;

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
                  initialValue: newBankName,
                  onChanged: (value) {
                    setState(() {
                      newBankName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Bank Name'),
                ),
                TextFormField(
                  initialValue: newAccountNumber,
                  onChanged: (value) {
                    setState(() {
                      newAccountNumber = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Account Number'),
                ),
                TextFormField(
                  initialValue: newIfscCode,
                  onChanged: (value) {
                    setState(() {
                      newIfscCode = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'IFSC Code'),
                ),
                TextFormField(
                  initialValue: newUpiNumber,
                  onChanged: (value) {
                    setState(() {
                      newUpiNumber = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'UPI Id'),
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
                sellerServices.updateSellerBankInformation(context, newBankName,
                    newAccountNumber, newIfscCode, newUpiNumber);
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
                  "Your Bank Details",
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
                  initialValue: seller.bankname,
                  decoration: InputDecoration(
                    label: Text("Bank Name"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter your bank name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: seller.accountNumber,
                  decoration: InputDecoration(
                    label: Text("Account Number"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter account number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: seller.ifscCode,
                  decoration: InputDecoration(
                    label: Text("IFSC Code"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter IFSC code";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: seller.upiId,
                  decoration: InputDecoration(
                    label: Text("UPI Id"),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter UPI number";
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
