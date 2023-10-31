import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/constants/global_variables.dart';

class ProductOrders extends StatelessWidget {
  final String image;
  final String name;
  final double price;

  const ProductOrders(
      {Key? key, required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 2, // Adjust max lines if needed
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '₹${price.toString()}',
                            maxLines: 2, // Adjust max lines if needed
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.red.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
