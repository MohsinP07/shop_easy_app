// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/common/widgets/stars.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/constants/utils.dart';
import 'package:shop_easy_ecommerce/features/address/screens/address_screen.dart';
import 'package:shop_easy_ecommerce/features/address/screens/buy_now_screen.dart';
import 'package:shop_easy_ecommerce/features/product_details/services/product_details_services.dart';
import 'package:shop_easy_ecommerce/features/search/screens/search_screen.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double avgRating = 0;
  double myRating = 0;

  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
  }

  void addToWishlist() {
    productDetailsServices.addToWishlist(
        context: context, product: widget.product);
  }

  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(context, BuyNowScreen.routeName,
        arguments: sum.toString());
  }

  void buyNow(int sum) {
    productDetailsServices.buyNow(context: context, product: widget.product);
    navigateToAddressScreen(sum);
  }

  String getFirstLine(String text) {
    // Function to get the first line of the description
    int breakIndex = text.indexOf('\n');
    return breakIndex != -1 ? text.substring(0, breakIndex) : text;
  }

  showFullDiscription(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Product Description"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final deviceSize = MediaQuery.of(context).size;
    int sum = (widget.product.price).toInt();

    // user.cart
    //     .map((e) => sum += e['quantity'] * e['product']['price'] as int)
    //     .toList();
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
                            hintText: 'Search ShopEasy.in',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            if (widget.product.sellerShopName == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("Best Seller"),
                    Container(
                      width: 80,
                      height: 40,
                      child: Image.asset(
                        "assets/images/best_seller.png",
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 100,
                        height: 40,
                        child: Image.asset(
                          "assets/images/shopeasy_choice.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: addToWishlist,
                    icon: Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.red,
                    ))
              ],
            ),
            CarouselSlider(
                items: widget.product.images.map((i) {
                  return Builder(
                      builder: (BuildContext context) => Image.network(
                            i,
                            fit: BoxFit.contain,
                            height: 200,
                          ));
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, height: 300)),
            SizedBox(
              height: 6,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                  text: TextSpan(
                      text: "Deal Price: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                      text: "\₹${widget.product.price} Only",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    )
                  ])),
            ),
            if (widget.product.quantity < 5 && widget.product.quantity >= 1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Only ${widget.product.quantity.toInt()} left!!",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber),
                ),
              ),
            if (widget.product.quantity == 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Out of Stock!!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ),
            ListTile(
              onTap: () =>
                  showFullDiscription(context, widget.product.description),
              title: Text(getFirstLine(widget.product.description)),
              leading: Icon(Icons.info),
              trailing: IconButton(
                  onPressed: () =>
                      showFullDiscription(context, widget.product.description),
                  icon: Icon(Icons.keyboard_arrow_right)),
            ),
            if (widget.product.sellerShopName != 'ShopEasy' &&
                widget.product.sellerShopName != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Sold by: ',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.product.sellerShopName!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: "Buy Now!",
                onTap: () {
                  if (widget.product.quantity == 0) {
                    showSnackBar(context, "This product is out of stock!");
                  } else {
                    buyNow(sum);
                    print(sum);
                  }
                },
                color: widget.product.quantity == 0
                    ? Colors.grey
                    : GlobalVariables.secondaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: "Add to Cart!",
                onTap: () {
                  if (widget.product.quantity == 0) {
                    print(widget.product.quantity);
                    showSnackBar(context, "This product is out of stock!");
                  } else {
                    print(widget.product.quantity);
                    addToCart();
                  }
                },
                color: widget.product.quantity == 0
                    ? Colors.grey
                    : GlobalVariables.secondaryColorLight,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: deviceSize.width,
                height: deviceSize.height * 10 / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: Text(
                        "Rate the product",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RatingBar.builder(
                        initialRating: myRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: GlobalVariables.secondaryColorLight,
                            ),
                        onRatingUpdate: (rating) {
                          productDetailsServices.rateProduct(
                              context: context,
                              product: widget.product,
                              rating: rating);
                          showSnackBar(context, "Thanks for rating!!");
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
