import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shop_easy_ecommerce/features/admin/models/sales.dart';

class SellerChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const SellerChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
