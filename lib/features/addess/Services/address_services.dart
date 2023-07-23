import 'dart:convert';
import 'dart:io';
import 'package:amazon/Constant/errorhandling.dart';
import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/Constant/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final Userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          'x-auth-token': Userprovider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            User user = Userprovider.user.copywith(
              address: jsonDecode(res.body)['address'],
            );
            Userprovider.setUserFromModel(user);
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json',
            'charset': 'utf-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      httpErrorhandle(res: res, context: context, onsuccess: () {
        Showsnackbar(context,'Your Order has been placed ');
        User user=userProvider.user.copywith(
          cart: [],

        );
        userProvider.setUserFromModel(user);

      });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }

  }


}
