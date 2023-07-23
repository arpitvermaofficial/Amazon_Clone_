import 'package:amazon/common/widgets/Custom_Buttom.dart';
import 'package:amazon/features/cart/widgets/cart_product.dart';
import 'package:amazon/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon/features/home/Widgets/addressbox.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/global_variable.dart';
import '../../../models/product.dart';
import '../../Search/Screens/Search_Screen.dart';
import '../../addess/screens/address_screen.dart';


class CartScreen extends StatefulWidget {

  const   CartScreen({Key? key, }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override

  void navigateToSearchScreen(String query  ){
    Navigator.pushNamed(context ,SearchScreen.routename ,arguments: query);
  }
  void navigateToAddressScreen(int sum){
    Navigator.pushNamed(context ,Address.routeName,arguments:sum.toString()  );
  }
  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int ).toList();

    return  Scaffold(
        appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: Globalariables.appBarGradient),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Container(
              height: 42,
              margin: EdgeInsets.only(left: 15),
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(top: 10),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide(color: Colors.black38, width: 1),
                    ),
                    hintText: 'Search Amazon.in',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 17),
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 6,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          ),
        ]),
      ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Addressbox(),
            const CartSubtotal(),
            CustomButton(text: 'Proceed to Buy(${user.cart.length})', onTap: (){
              navigateToAddressScreen(sum);
            },color:Colors.yellow[600],),
        const SizedBox(height: 15,),
          Container(color: Colors.black12.withOpacity(0.08),height: 1,),
          const SizedBox(height: 5,),
            ListView.builder(itemCount:user.cart.length,
                itemBuilder: (context,index){
              return CartProduct(index: index);

            },
            shrinkWrap: true,)

          ]
        ),
      ),
    );
  }
}
