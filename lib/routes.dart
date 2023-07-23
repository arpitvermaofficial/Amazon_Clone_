import 'package:amazon/features/Search/Screens/Search_Screen.dart';
import 'package:amazon/features/addess/screens/address_screen.dart';
import 'package:amazon/features/home/Screen/category_details.dart';
import 'package:amazon/features/home/Screen/home_screen.dart';
import 'package:amazon/features/home/ordered_details/Screens/ordered_detailed_screen.dart';
import 'package:amazon/features/product_details/Screens/product_details_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'common/widgets/bottombar.dart';
import 'features/Admin/Screens/add_product.dart';
import 'features/auth/screens/auth_screen.dart';

Route<dynamic> generateroute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AuthScreen());
     case HomeScreen.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());
    case Categorydealscreen.routeName:
      var category =routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Categorydealscreen(category: category));
    case Add_Product.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Add_Product());
    case Address.routeName:
      var totalAmount =routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Address(totalamount: totalAmount,));
    case ProductDetailsScreen.routename:
      var product =routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ProductDetailsScreen(product: product));
    case SearchScreen.routename:
      var searchquery =routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SearchScreen(searchquery: searchquery,));
    case Bottombar.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Bottombar());
    case OrderedDetailsScreen.routeName:
      var order =routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => OrderedDetailsScreen(order: order));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(
                  child: Text("screen Not Found"),
                ),
              ));
  }
}
