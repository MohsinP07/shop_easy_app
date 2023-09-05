import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shop_easy_ecommerce/common/widgets/loader.dart';
import 'package:shop_easy_ecommerce/features/admin/models/sales.dart';
import 'package:shop_easy_ecommerce/features/admin/widgets/category_products_chart.dart';
import 'package:shop_easy_ecommerce/features/seller/services/seller_services.dart';
import 'package:shop_easy_ecommerce/features/seller/widgets/seller_chart.dart';

class SellerAnalticsScreen extends StatefulWidget {
  const SellerAnalticsScreen({super.key});

  @override
  State<SellerAnalticsScreen> createState() => _SellerAnalticsScreenState();
}

class _SellerAnalticsScreenState extends State<SellerAnalticsScreen> {
  final SellerServices sellerServices = SellerServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await sellerServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];

    print(earnings);
    print(totalSales);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: SellerChart(seriesList: [
                  charts.Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earnings)
                ]),
              )
            ],
          );
  }
}
