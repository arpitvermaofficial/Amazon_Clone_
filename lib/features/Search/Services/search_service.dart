import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../../Constant/errorhandling.dart';
import '../../../Constant/global_variable.dart';
import '../../../Constant/utils.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices{
  Future<List<Product>> fetchSearchProducts(
      {required BuildContext context, required String searchQuery}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productlist = [];

    try {
    http.Response res =
    await http.get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
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
}

