import 'package:amazon/features/Admin/Screens/analytics_screen.dart';
import 'package:amazon/features/Admin/Screens/orders_screen.dart';
import 'package:amazon/features/Admin/Screens/post_screen.dart';
import 'package:flutter/material.dart';

import '../../../Constant/global_variable.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int page_index = 0;
  double bottombarwidth = 42;
  double bottomborderwidth = 5;
  void updatepage(int page){
    setState(() {
      page_index=page;

    });
  }
  List<Widget>pages=[

    PostsScreen(),
    AnalyticsScreen(),
    Orders_Screen( )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page_index],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Globalariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)

            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          onTap:updatepage,
          items: [
            //home
            BottomNavigationBarItem(
                icon: Container(
                  width: bottombarwidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: page_index == 0
                              ? Globalariables.selectedNavBarColor
                              : Globalariables.backgroundColor,
                          width: bottomborderwidth),
                    ),
                  ),
                  child: const Icon(Icons.home_outlined),
                ),
                label: ''),
            //acount
            BottomNavigationBarItem(
                icon: Container(
                  width: bottombarwidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: page_index == 1
                              ?Globalariables.selectedNavBarColor
                              :Globalariables.backgroundColor,
                          width: bottomborderwidth),
                    ),
                  ),
                  child: const Icon(Icons.analytics_outlined),
                ),
                label: ''),
            //cart
            BottomNavigationBarItem(
                icon: Container(
                  width: bottombarwidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: page_index ==2
                              ? Globalariables.selectedNavBarColor
                              : Globalariables.backgroundColor,
                          width: bottomborderwidth),
                    ),
                  ),
                  child: Badge(
                    label: const Text('2'),
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.all_inbox_outlined),
                    textColor: Colors.black,
                  ),
                ),
                label: ''),
          ],
          currentIndex: page_index,
          selectedItemColor: Globalariables.selectedNavBarColor,
          unselectedItemColor: Globalariables.unselectedNavBarColor,
          backgroundColor: Globalariables.backgroundColor,
          iconSize: 28,
        )

    );
  }
}
