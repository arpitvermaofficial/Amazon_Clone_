import 'package:amazon/features/account/widgets/below_appbar.dart';
import 'package:amazon/features/account/widgets/orders.dart';
import 'package:amazon/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:amazon/Constant/global_variable.dart';
class Account_screen extends StatelessWidget {
  const Account_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const  BoxDecoration(
                gradient: Globalariables.appBarGradient
              ),
            ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/amazon_in.png",width: 120,height:45,color: Colors.black,),
              ),
              Container(
                padding:const EdgeInsets.only(left: 15,right: 15),
                child:const Row(children: [
                  Padding(padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined),),
                  Icon(Icons.search_outlined),
                ],)
              )
            ],
          ),
        ),
      ),
      body:  const Column(
        children: [
          Belowappbar(),
          SizedBox(height: 10,),
          TopButton(),
          SizedBox(height: 20,),
          Orders()
        ],
      ),
    );
  }
}
