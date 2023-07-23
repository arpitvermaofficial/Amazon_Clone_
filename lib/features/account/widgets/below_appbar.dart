import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Belowappbar extends StatelessWidget {
  const Belowappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserProvider>(context).user;

    return Container(
      decoration: BoxDecoration(
        gradient: Globalariables.appBarGradient
      ),
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Row(
        children: [
          RichText(
              text:  TextSpan(
                text: 'Hello ,',
                style:const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(
                  text: user.name,
                  style:const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),),
                ]
              ),
          ),
        ],
      ),
    );

  }
}
