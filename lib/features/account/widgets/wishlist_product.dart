import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';
import 'package:shop_easy_ecommerce/features/account/services/account_services.dart';
import 'package:shop_easy_ecommerce/features/product_details/services/product_details_services.dart';
import 'package:shop_easy_ecommerce/models/product.dart';

class WishlistProduct extends StatelessWidget {
  final Product product;

  const WishlistProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();
    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();

    void decreaseQuantity(Product product) {
      accountServices.removeFromWishList(context: context, product: product);
    }

    void addToCart() {
      productDetailsServices.addToCart(context: context, product: product);
    }

    double containerWidth = MediaQuery.of(context).size.width * 0.4;

    return SingleChildScrollView(
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.fitHeight,
                    height: 135,
                    width: 135,
                  ),
                  Column(
                    children: [
                      Container(
                        width: containerWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: containerWidth,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          '\₹${product.price}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: containerWidth,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text("Eligible for FREE Shipping"),
                      ),
                      Container(
                        width: containerWidth,
                        height: 40,
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: CustomButton(
                          text: "Add to Cart!",
                          onTap: addToCart,
                          color: const Color.fromRGBO(254, 216, 19, 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => decreaseQuantity(product),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => decreaseQuantity(product),
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                  const Text(
                    "Remove from wishlist",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
