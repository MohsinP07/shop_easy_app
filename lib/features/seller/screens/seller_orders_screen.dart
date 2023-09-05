import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/account/widgets/single_product.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';
import 'package:shop_easy_ecommerce/features/order_details/screens/order_details_screen.dart';
import 'package:shop_easy_ecommerce/features/seller/services/seller_services.dart';
import 'package:shop_easy_ecommerce/models/order.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  List<Order>? orders;
  final SellerServices sellerServices = SellerServices();

  @override
  void initState() {
    super.initState();

    fetchOrders();
  }

  fetchOrders() async {
    orders = await sellerServices.fetchAllOrders(context);
    print(orders);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
