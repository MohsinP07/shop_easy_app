import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/wishlist_product.dart';
import 'package:shop_easy_ecommerce/models/product.dart';
import 'package:shop_easy_ecommerce/providers/user_provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final AccountServices accountServices = AccountServices();

  void removeFromWishList(Product product) {
    accountServices.removeFromWishList(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    // Ensure that the wishlist is a list of Product objects
    List<Product> wishlistProducts = user.wishlist
        .map((item) => Product.fromMap(
            item['product'])) // Assuming `item` contains a `product` map
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Your other widgets
          wishlistProducts.isEmpty
              ? Text("Your wishlist is empty!")
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: wishlistProducts
                        .map((product) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: WishlistProduct(
                                  product: product), // Pass product here
                            ))
                        .toList(),
                  ),
                ),
          if (wishlistProducts.isNotEmpty)
            const Text(
              "Scroll for more >>>",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: GlobalVariables.secondaryColor,
                  fontWeight: FontWeight.w200),
            )
        ],
      ),
    );
  }
}
