import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/Services/home_services.dart';
import 'package:amazon/features/product_details/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../Constant/global_variable.dart';
import '../../../models/product.dart';

class Categorydealscreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const Categorydealscreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<Categorydealscreen> createState() => _CategorydealscreenState();
}

class _CategorydealscreenState extends State<Categorydealscreen> {
  final Homeservices homeservices=Homeservices();
  List<Product>?productlist;
  @override
  void initState() {

    super.initState();
    fetchCategoryProducts();
  }
  void fetchCategoryProducts()async{
    productlist=await homeservices.fetchCategoryProducts(context: context, category: widget.category);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Globalariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productlist==null?const Loader():Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shoping for ${widget.category}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              itemCount: productlist!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 10),
                itemBuilder: (context,index){
                final product=productlist![index];
                  return GestureDetector(
                    onTap: ()=>Navigator.pushNamed(context, ProductDetailsScreen.routename,arguments: product),
                    child: Column(
                      children: [
                        SizedBox(
                          height:  130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.black12
                              ),
                            ),
                            child: Padding(padding: const EdgeInsets.only(),
                            child: Image.network(product.images[0]),),
                          ),
                        ), Container(
                          alignment:  Alignment.topLeft,
                          padding: const EdgeInsets.only(left:15,top:5,right: 15),
                          child: Text(product.name,maxLines:1,overflow: TextOverflow.ellipsis,),
                        )
                      ],
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }
}
