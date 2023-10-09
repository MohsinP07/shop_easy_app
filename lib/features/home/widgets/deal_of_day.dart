// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/home/services/home_services.dart';
import 'package:shop_easy_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigatetoDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigatetoDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.shade300,
                            Colors.teal.shade100
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                              height: 30,
                              width: 60,
                              child: Image.asset(
                                fit: BoxFit.contain,
                                "assets/images/deals.png",
                              )),
                          SizedBox(
                            width: deviceSize.width * 0.5 / 100,
                          ),
                          Text(
                            "Deal of the day!!",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.1 / 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 8,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlue.shade200,
                                      Colors.teal.shade100
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      product!.images[0],
                                      height: 235,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 5, right: 40),
                                      child: Text(
                                        product!.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.topLeft,
                                      child: Text('\₹${product!.price} Only',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      color: Colors.black12,
                                      height: 3,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: product!.images
                                              .map(
                                                (e) => Image.network(
                                                  e,
                                                  fit: BoxFit.contain,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              )
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "See all the deals",
                        style: TextStyle(color: Colors.cyan.shade800),
                      ),
                    )
                  ],
                ),
              );
  }
}
