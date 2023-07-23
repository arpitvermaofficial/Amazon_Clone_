import 'dart:convert';

import 'package:amazon/Constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorhandle({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onsuccess,
}) {
  switch (res.statusCode) {
    case 200:
    onsuccess();
      break;
    case 400:
    Showsnackbar(context, jsonDecode(res.body)['msg']);
      break;
      case 500:
    Showsnackbar(context, jsonDecode(res.body)['error']);
      break;
      default:
       Showsnackbar(context, res.body);
  }
}
