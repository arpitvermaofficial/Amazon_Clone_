import 'dart:convert';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constant/errorhandling.dart';
import '../../../Constant/global_variable.dart';
import '../../../Constant/utils.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart' as http;

class AccountServices{
  Future<List<Order>> fetchMyOrder(
      {required BuildContext context,}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderlist = [];

    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderlist
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return orderlist;
  }
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
            (route) => false,
      );

    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }
}