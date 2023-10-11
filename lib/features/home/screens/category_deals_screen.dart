// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/common/widgets/stars.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/home/services/home_services.dart';
import 'package:shop_easy_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        if (widget.category == 'Mobiles')
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/mob_cat.png")),
                        if (widget.category == 'Essentials')
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/ess_cat.png")),
                        if (widget.category == 'Appliances')
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/app_cat.png")),
                        if (widget.category == 'Books')
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/book_cat.png")),
                        if (widget.category == 'Fashion')
                          SizedBox(
                              width: 32,
                              height: 32,
                              child:
                                  Image.asset("assets/images/fashion_cat.png")),
                        SizedBox(
                          width: deviceSize.width * 1.5 / 100,
                        ),
                        Text(
                          "Keep shopping for ${widget.category}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height,
                    child: ListView.builder(
                        padding: EdgeInsets.only(left: 15),
                        itemCount: productList!.length,
                        itemBuilder: (context, index) {
                          final product = productList![index];
                          double totalRating = 0;
                          for (int i = 0; i < product.rating!.length; i++) {
                            totalRating += product.rating![i].rating;
                          }
                          double avgRating = 0;
                          if (totalRating != 0) {
                            avgRating = totalRating / product.rating!.length;
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailsScreen.routeName,
                                  arguments: product);
                            },
                            child: Card(
                              elevation: 8,
                              color: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFB3E0FF), Colors.white],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 130,
                                        width: 160,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 0.5)),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Image.network(
                                                product.images[0]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: deviceSize.width * 2.5 / 100,
                                      ),
                                      Container(
                                        width: deviceSize.width * 50 / 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 0, top: 0, right: 15),
                                              child: Text(
                                                product.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 0, top: 0, right: 15),
                                              child: Text(
                                                product.description,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 0, top: 0, right: 15),
                                              child: Text(
                                                '₹${product.price}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 0, top: 0, right: 15),
                                                child:
                                                    Stars(rating: avgRating)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
