import 'package:amazon/features/Admin/Admin_Services/admin_services.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/home/ordered_details/Screens/ordered_detailed_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/order.dart';

class Orders_Screen extends StatefulWidget {
  const Orders_Screen({Key? key}) : super(key: key);

  @override
  State<Orders_Screen> createState() => _Orders_ScreenState();
}

class _Orders_ScreenState extends State<Orders_Screen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return orders==null?const Loader():GridView.builder(
        itemCount: orders!.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final orderData = orders![index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, OrderedDetailsScreen.routeName,arguments: orderData);
            },
            child: SizedBox(
              height: 140,
              child: SingleProduct(image: orderData.products[0].images[0]),
            ),
          );
        });
  }
}
