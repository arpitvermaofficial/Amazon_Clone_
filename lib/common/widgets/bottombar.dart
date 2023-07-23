import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/features/account/screens/account_screen.dart';
import 'package:amazon/features/cart/screens/cart_screen.dart';
import 'package:amazon/features/home/Screen/home_screen.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottombar extends StatefulWidget {
  static const String routename = "/actual-home";
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int page_index = 0;

  @override
  Widget build(BuildContext context) {

    double bottombarwidth = 42;
    double bottomborderwidth = 5;
    void updatepage(int page){
      setState(() {
        page_index=page;

      });
    }
    List<Widget>pages=[
      HomeScreen(),
      Account_screen(),
     CartScreen()
    ];
    final userCartLen=context.watch<UserProvider>().user.cart.length;
    // print(userCartLen.toString());

    return Scaffold(
      body: pages[page_index],
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
              child: const Icon(Icons.person_outline_outlined),
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
                 label:  Text(userCartLen.toString()),
                backgroundColor: Colors.white,
                child: const Icon(Icons.shopping_cart_outlined),
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
    ));
  }
}
