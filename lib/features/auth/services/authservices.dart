import 'dart:convert';
import 'package:amazon/Constant/errorhandling.dart';
import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/Constant/utils.dart';
import 'package:amazon/common/widgets/bottombar.dart';
import 'package:amazon/features/home/Screen/home_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authservices {
  void signupuser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          address: '',
          password: password,
          token: '',
          id: '',
          email: email,
          name: name,
          type: '',
      cart: []);
      http.Response res = await http.post(
          Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(res.body);
      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            Showsnackbar(context, 'Account Created Successfully');
          });
    } catch (e) {
      Showsnackbar(context, "hello" + e.toString());
    }
  }

  void siginuser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/signin'),
              body: jsonEncode({
                'email': email,
                'password': password,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            final String? action = prefs.getString('x-auth-token');
            print(action);
            Navigator.pushNamedAndRemoveUntil(
                context, Bottombar.routename, (route) => false);
          });
    } catch (e) {
      Showsnackbar(context, "hello" + e.toString());
    }
  }

  void getuserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http
          .post(Uri.parse('$uri/tokenIsvalid'),
          headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
          headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      }
      
      );

      var userprovider = Provider.of<UserProvider>(context, listen: false);
      userprovider.setUser(userRes.body);
      }
    } catch (e) {

      Showsnackbar(context, "hello" + e.toString());
    }
  }
}
