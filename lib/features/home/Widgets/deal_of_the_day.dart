import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/Services/home_services.dart';
import 'package:amazon/features/product_details/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class Dealoftheday extends StatefulWidget {
  const Dealoftheday({Key? key}) : super(key: key);

  @override
  State<Dealoftheday> createState() => _DealofthedayState();
}

class _DealofthedayState extends State<Dealoftheday> {
  Product? product;
  final Homeservices homeservices = Homeservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeservices.fetchDealOfDay(
      context: context,
    );
    setState(() {});
  }
  void navigateToDetailsScreen(){
    Navigator.pushNamed(context, ProductDetailsScreen.routename,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
      onTap: navigateToDetailsScreen,
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal Of the Day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      fit: BoxFit.fitHeight,
                      height: 235,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "\$100",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        "arpit",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(e,
                                  fit: BoxFit.fitWidth, width: 100, height: 100),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
            );
  }
}
