// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_textfield.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/address/services/address_services.dart';
import 'package:shop_easy_ecommerce/features/search/screens/search_screen.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class BuyNowScreen extends StatefulWidget {
  static const String routeName = '/buy-now-screen';
  final String totalAmount;

  const BuyNowScreen({super.key, required this.totalAmount});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
  }

  TextEditingController flatBuildingController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressAndPhoneToBeUsed = '';
  final AddressServices addressServices = AddressServices();
  int count = 0;
  String phone = '';
  var address = '';

  @override
  void didChangeDependencies() {
    if (count == 0) {
      phone = context.watch<UserProvider>().user.phone;
      address = context.watch<UserProvider>().user.address;
      count++;
    }
    super.didChangeDependencies();
  }

  @override
  dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaStreetController.dispose();
    pinCodeController.dispose();
    townCityController.dispose();
  }

  void onApplePayResult(res) {}
  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressAndPhoneToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressAndPhoneToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void cashOnDelivery() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressAndPhoneToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressAndPhoneToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromTheProvider) {
    addressAndPhoneToBeUsed = '';
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaStreetController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        townCityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressAndPhoneToBeUsed =
            '${flatBuildingController.text}, ${areaStreetController.text}, ${townCityController.text} - ${pinCodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromTheProvider.isNotEmpty) {
      addressAndPhoneToBeUsed = addressFromTheProvider;
    } else {
      showSnackBar(context, "ERROR");
    }
    cashOnDelivery();
    print(addressAndPhoneToBeUsed);
  }

  String selectedPaymentMethod = "Card";

  List<String> paymentMethods = [
    'Card',
    'Cash On Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    // var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Buy Now!!"),
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: "Flat, House no, Building",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: areaStreetController,
                        hintText: "Area, Street",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: pinCodeController,
                        hintText: "Pincode",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: townCityController,
                        hintText: "Town/City",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: phone,
                        decoration: InputDecoration(
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
                      )
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text("Payment method: "),
                  SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    child: DropdownButton(
                      value: selectedPaymentMethod,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: paymentMethods.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          selectedPaymentMethod = newVal!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              selectedPaymentMethod == 'Card'
                  ? GooglePayButton(
                      onPaymentResult: onGooglePayResult,
                      paymentItems: paymentItems,
                      paymentConfigurationAsset: 'gpay.json',
                      height: 50,
                      type: GooglePayButtonType.buy,
                      margin: EdgeInsets.only(top: 15),
                      loadingIndicator: Center(
                        child: CircularProgressIndicator(),
                      ),
                      onPressed: () => payPressed(address),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black12,
                        )),
                        child: CustomButton(
                            text: "Buy Now!!",
                            onTap: () => payPressed(address),
                            color: GlobalVariables.secondaryColor),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
