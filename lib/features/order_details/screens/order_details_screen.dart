// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';
import 'package:shop_easy_ecommerce/features/search/screens/search_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/services/seller_services.dart';
import 'package:shop_easy_ecommerce/models/order.dart';
import 'package:intl/intl.dart';
import 'package:shop_easy_ecommerce/providers/seller_provider.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int count = 0;
  var user;
  var seller;

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  final SellerServices sellerServices = SellerServices();

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  //only for admin
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {});
    setState(() {
      currentStep += 1;
    });
  }

  //only for seller
  void changeOrderStatusSeller(int status) {
    sellerServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {});
    setState(() {
      currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final seller = Provider.of<SellerProvider>(context).seller;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: EdgeInsets.only(left: 15, top: 12),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: 'Search Amazon.in',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Order Date:                 ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                    Text("Order Id:                      ${widget.order.id}"),
                    Text(
                        "Order Total:                \₹${widget.order.totalPrice}"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchase Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Qty: ${widget.order.quantity[i]}',
                              ),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tracking",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Stepper(
                    currentStep: currentStep <= 3
                        ? currentStep
                        : 3, // Ensure currentStep is within the valid range
                    controlsBuilder: (context, details) {
                      if (user.type == 'admin' || seller.type == 'seller') {
                        if (currentStep < 3) {
                          return CustomButton(
                            text: "Done",
                            onTap: () {
                              if (user.type == 'admin') {
                                changeOrderStatus(details.currentStep);
                              } else {
                                changeOrderStatusSeller(details.currentStep);
                              }
                              if (details.currentStep == 3) {
                                showSnackBar(context, "Order Completed!!");
                              }
                            },
                          );
                        }
                      } else if (user.type == 'user') {
                        return SizedBox();
                      }
                      return SizedBox();
                    },
                    steps: [
                      Step(
                        title: Text("Pending"),
                        content: Text("Your order is yet to be delivered"),
                        isActive: currentStep >= 0,
                        state: currentStep >= 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Completed"),
                        content: Text(
                          "Your order has been delivered, and you are yet to sign",
                        ),
                        isActive: currentStep >= 1,
                        state: currentStep >= 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Received"),
                        content: Text(
                          "Your order has been delivered and signed by you",
                        ),
                        isActive: currentStep >= 2,
                        state: currentStep >= 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Delivered"),
                        content: Text(
                          "Your order has been delivered and signed by you!",
                        ),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
