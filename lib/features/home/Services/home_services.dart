import 'dart:convert';
import 'package:amazon/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import '../../../Constant/errorhandling.dart';
import '../../../Constant/global_variable.dart';
import '../../../Constant/utils.dart';
import '../../../provider/user_provider.dart';

class Homeservices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productlist = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productlist
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return productlist;
  }


  Future<Product> fetchDealOfDay(
      {required BuildContext context}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product =Product(description: '', quantity:0, images:[], name: '', category:'', price: 0);

    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
           product=Product.fromJson(res.body);
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return product;
  }
}
