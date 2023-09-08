// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
import 'package:upi_india/upi_india.dart';

class BuyNowScreen extends StatefulWidget {
  static const String routeName = '/buy-now-screen';
  final String totalAmount;

  const BuyNowScreen({super.key, required this.totalAmount});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

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

    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
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
  bool newAddressExpanded = false;

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

  List<String> paymentMethods = ['Card', 'Cash On Delivery', "UPI"];

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: 'global.mohsinpatel786@ybl',
        receiverName: "ShopEasy Payment",
        transactionNote: "ShopEasy Online Payment",
        transactionRefId: "123456789",
        amount: double.parse(widget.totalAmount));
  }

  Widget displayApps() {
    if (apps == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return Center(
        // You were missing 'return' here
        child: Text("No apps found to handle transactions"),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name)
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: Theme.of(context).textTheme.titleSmall),
          Flexible(
              child: Text(
            body,
          )),
        ],
      ),
    );
  }

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
              SizedBox(
                height: 14,
              ),
              Text("Payment details"),
              Column(
                children: [
                  ListTile(
                    title: Text("Subtotal"),
                    trailing: Text(widget.totalAmount),
                  ),
                  ListTile(
                    title: Text("Shipping"),
                    trailing: Text("Free"),
                  ),
                  ListTile(
                    title: Text("Tax"),
                    trailing: Text("0"),
                  ),
                  ListTile(
                    title: Text("Discount"),
                    trailing: Text("0"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(widget.totalAmount),
                  ),
                ],
              ),
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
              Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Icon(Icons.add),
                    title: Text("Add another address"),
                    trailing: Icon(newAddressExpanded
                        ? Icons.expand_less
                        : Icons.expand_more),
                    onTap: () {
                      setState(() {
                        newAddressExpanded = !newAddressExpanded;
                      });
                    },
                  ),
                  if (newAddressExpanded)
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
                                    borderSide:
                                        BorderSide(color: Colors.black38)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38)),
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
                ],
              ),
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
              if (selectedPaymentMethod == 'Card')
                GooglePayButton(
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
                ),
              if (selectedPaymentMethod == 'Cash On Delivery')
                Padding(
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
                ),
              if (selectedPaymentMethod == 'UPI')
                Container(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [
                      Expanded(child: displayApps()),
                      Expanded(
                        child: FutureBuilder(
                          future: _transaction,
                          builder: (BuildContext context,
                              AsyncSnapshot<UpiResponse> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    _upiErrorHandler(
                                        snapshot.error.runtimeType),
                                  ), // Print's text message on screen
                                );
                              }

                              // If we have data then definitely we will have UpiResponse.
                              // It cannot be null
                              UpiResponse _upiResponse = snapshot.data!;

                              // Data in UpiResponse can be null. Check before printing
                              String txnId =
                                  _upiResponse.transactionId ?? 'N/A';
                              String resCode =
                                  _upiResponse.responseCode ?? 'N/A';
                              String txnRef =
                                  _upiResponse.transactionRefId ?? 'N/A';
                              String status = _upiResponse.status ?? 'N/A';
                              String approvalRef =
                                  _upiResponse.approvalRefNo ?? 'N/A';
                              _checkTxnStatus(status);

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      displayTransactionData(
                                          'Transaction Id', txnId),
                                      displayTransactionData(
                                          'Response Code', resCode),
                                      displayTransactionData(
                                          'Reference Id', txnRef),
                                      displayTransactionData(
                                          'Status', status.toUpperCase()),
                                      displayTransactionData(
                                          'Approval No', approvalRef),
                                    ],
                                  ),
                                ),
                              );
                            } else
                              return Center(
                                child: Text(''),
                              );
                          },
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
