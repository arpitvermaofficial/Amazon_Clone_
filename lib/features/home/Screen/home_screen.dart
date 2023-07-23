import 'package:amazon/features/Search/Screens/Search_Screen.dart';
import 'package:amazon/features/home/Widgets/addressbox.dart';
import 'package:amazon/features/home/Widgets/crousel_image.dart';
import 'package:amazon/features/home/Widgets/deal_of_the_day.dart';
import 'package:amazon/features/home/Widgets/top_categories.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/global_variable.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void navigateToSearchScreen(String query  ){
    Navigator.pushNamed(context ,SearchScreen.routename ,arguments: query);
  }
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
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
                    onFieldSubmitted:navigateToSearchScreen,
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
              child: const Icon(Icons.mic,color: Colors.black,size: 25,),
            ),
          ]),
        ),
      ),
      body:SingleChildScrollView(
        child: const Column(
          children: [
            Addressbox(),
            SizedBox(height :10),
            TopCategories(),
            SizedBox(height :10),
            CrouselImage(),
            SizedBox(height :10),
            Dealoftheday(),


            ],
        ),
      )
    );
  }
}
