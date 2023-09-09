import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/custom_button.dart';

class SingleSellers extends StatelessWidget {
  final String shopName;
  final String name;
  final String email;
  final VoidCallback onTap;
  const SingleSellers(
      {super.key,
      required this.shopName,
      required this.name,
      required this.onTap,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Container(
            width: 180,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [Text(shopName)],
                ),
                Text(name),
                Text(email),
                IconButton(onPressed: onTap, icon: Icon(Icons.delete))
              ],
            )),
      ),
    );
  }
}
