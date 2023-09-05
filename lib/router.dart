// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/bottom_bar.dart';
import 'package:shop_easy_ecommerce/features/address/screens/address_screen.dart';
import 'package:shop_easy_ecommerce/features/address/screens/buy_now_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/add_products_screen.dart';
import 'package:shop_easy_ecommerce/features/admin/screens/admin_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_seller_screen.dart';
import 'package:shop_easy_ecommerce/features/auth/screens/signup_user_screen.dart';
import 'package:shop_easy_ecommerce/features/home/screens/category_deals_screen.dart';
import 'package:shop_easy_ecommerce/features/home/screens/home_screen.dart';
import 'package:shop_easy_ecommerce/features/order_details/screens/order_details_screen.dart';
import 'package:shop_easy_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:shop_easy_ecommerce/features/search/screens/search_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/screens/seller_add_products_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/screens/seller_screen.dart';
import 'package:shop_easy_ecommerce/models/order.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AuthScreen());

    case SignUpUser.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SignUpUser());
    case SignUpSeller.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SignUpSeller());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => BottomBar());

    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AdminScreen());

    case SellerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SellerScreen());

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AddProductScreen());

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalAmount: totalAmount,
              ));

    case BuyNowScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BuyNowScreen(
                totalAmount: totalAmount,
              ));

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailScreen(
                order: order,
              ));

    case SellerAddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SellerAddProductScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(
                  child: Text("Screen does not exist!"),
                ),
              ));
  }
}
