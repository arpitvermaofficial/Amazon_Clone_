import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/Search/Services/search_service.dart';
import 'package:amazon/features/Search/Widgets/searched_product.dart';
import 'package:amazon/features/home/Widgets/addressbox.dart';
import 'package:amazon/features/product_details/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';


class SearchScreen extends StatefulWidget {
  final String searchquery;
  static const String routename='/search-screen';
  const SearchScreen({Key? key, required this.searchquery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>?products;
  final SearchServices searchServices=SearchServices();
  @override
  void navigateToSearchScreen(String query  ){
    Navigator.pushNamed(context ,SearchScreen.routename ,arguments: query);
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProduct();
  }
  void fetchSearchProduct()async{
    products=await searchServices.fetchSearchProducts(context: context, searchQuery: widget.searchquery);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
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
      body: products==null?const Loader():Column(
        children: [
          const Addressbox(
          ),
          const SizedBox(
            height: 10,

          ),
          Expanded(child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context,index){
                return
                GestureDetector(onTap: (){
                  Navigator.pushNamed(context, ProductDetailsScreen.routename,arguments: products![index]);
                },
                    child: SearchProduct(product: products![index]));

          }))
        ],
      )
    );
  }
}
