import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/Services/account_services.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/home/ordered_details/Screens/ordered_detailed_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';


class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  final AccountServices accountServices=AccountServices();
 List<Order>?orders;
  @override
  void initState(){
    super.initState();
    fetchorder();
  }
  void fetchorder()async{
    orders=await accountServices.fetchMyOrder(context: context, );
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    return orders==null?const Loader():Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              child:Text(
                'Your Orders',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15),
              child:Text(
                'See All',style: TextStyle(
                 color: Globalariables.selectedNavBarColor
              ),
              ),
            ),

          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10,top:20,right: 0),
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
              itemBuilder: (context,index)=>
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderedDetailsScreen.routeName,arguments: orders![index]);
                },
                  child: SingleProduct(image: orders![index].products[0].images[0]))
          ),

        )
      ],
    );
  }
}
