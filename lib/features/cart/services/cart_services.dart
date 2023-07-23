import 'dart:convert';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constant/errorhandling.dart';
import '../../../Constant/global_variable.dart';
import '../../../Constant/utils.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart' as http;
class CartServices{
  void removeFromCart(
      {required BuildContext context,
        required Product product,
      }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse('$uri/api/remove-from-cart/${product.id}'),
          headers: {
            'Content-Type': 'application/json',
            'charset': 'utf-8',
            'x-auth-token': userprovider.user.token,
          },
          body: jsonEncode({
            'id':product.id!,
          })
      );

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            User user= userprovider.user.copywith(
                cart:jsonDecode(res.body)['cart']
            );
            userprovider.setUserFromModel(user);
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

}