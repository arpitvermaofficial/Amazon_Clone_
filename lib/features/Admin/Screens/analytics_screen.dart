import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/Admin/Admin_Services/admin_services.dart';
import 'package:amazon/features/Admin/widgets/category_product_chart.dart';

import 'package:charts_flutter_new/flutter.dart'as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning),
                ]),
              )
            ],
          );
  }
}
