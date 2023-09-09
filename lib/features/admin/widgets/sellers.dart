// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/admin/services/admin_services.dart';
import 'package:shop_easy_ecommerce/models/seller.dart';

class Sellers extends StatefulWidget {
  const Sellers({super.key});

  @override
  State<Sellers> createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  List<Seller>? sellers;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();

    fetchAllSellers();
  }

  fetchAllSellers() async {
    sellers = await adminServices.fetchAllSellers(context);
    print(sellers);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return sellers == null
        ? Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total Sellers ( ${sellers!.length} )"),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: sellers!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final sellerData = sellers![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade500,
                        child: Text(
                            sellerData.sellername.toString().substring(0, 1)),
                      ),
                      title: Text(sellerData.sellername),
                      subtitle: Text(sellerData.shopname),
                    );

                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, OrderDetailScreen.routeName,
                    //         arguments: usersData);
                    //   },
                    //   child: SizedBox(
                    //     height: 140,
                    //     child: SingleProduct(image: usersData.products[0].images[0]),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          );
  }
}
