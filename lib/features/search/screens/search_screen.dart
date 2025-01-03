// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/home/widgets/address_box.dart';
import 'package:shop_easy_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:shop_easy_ecommerce/features/search/services/search_services.dart';
import 'package:shop_easy_ecommerce/features/search/widget/searched_product.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  late AnimationController _animationController;
  String query = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _searchController.text = widget.searchQuery;
    fetchSearchedProduct();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.8,
      upperBound: 1.2,
    );
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: _searchController.text);
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
      ),
      body: products == null
          ? Loader()
          : Column(
              children: [
                AddressBox(),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchedProduct(product: products![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
