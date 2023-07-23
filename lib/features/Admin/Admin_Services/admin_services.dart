import 'dart:convert';
import 'dart:io';
import 'package:amazon/Constant/errorhandling.dart';
import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/Constant/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import 'package:http/http.dart' as http;
import '../../../provider/user_provider.dart';
import '../../account/widgets/orders.dart';
import '../models/sales.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final Userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
    final cloudinary = CloudinaryPublic('dsdoeeiy3', 'uf9bqwmq');

    List<String> imageurls = [];
    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse response = await cloudinary.uploadFile(

        CloudinaryFile.fromFile(images[i].path,resourceType: CloudinaryResourceType.Image,folder: name),
      );

      imageurls.add(response.secureUrl);
    }


    Product product = Product(

      description: description,
      quantity: quantity,
      images: imageurls,
      name: name,
      category: category,
      price: price,
    );



    http.Response res = await http.post(
      Uri.parse('$uri/admin/add-product'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': Userprovider.user.token,
      },
      body: product.toJson(),
    );

    httpErrorhandle(
        res: res,
        context: context,
        onsuccess: () {
          Showsnackbar(context, 'Product Added Successfully');
          Navigator.pop(context);
        });
      } catch (e) {
        Showsnackbar(context, e.toString());
      }
    }


  Future<List<Product>> fetchAllproduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productlist = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final Userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          'x-auth-token': Userprovider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            onSuccess();
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }



  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderslist = [];

    try {
      http.Response res =
      await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderslist
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return orderslist;
  }

  void changeOrderStatus(
      {required BuildContext context,
        required int status,
        required Order order,
        required VoidCallback onSuccess}) async {
    final Userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          'x-auth-token': Userprovider.user.token,
        },
        body: jsonEncode({'id': order.id,'status':status}),
      );

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: onSuccess);
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
  }


  Future<Map<String,dynamic>>getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning=0;
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorhandle(
          res: res,
          context: context,
          onsuccess: () {
            var response=jsonDecode(res.body);
            totalEarning=response['totalEarnings'];
            sales=[
              Sales('Mobiles', response['mobileEarnings']),
              Sales('Essentials', response['EssentialsEarnings']),
              Sales('Appliances', response['AppliancesEarnings']),
              Sales('Mobiles', response['mobileEarnings']),
              Sales('Fashion', response['FashionEarnings']),

            ];
          });
    } catch (e) {
      Showsnackbar(context, e.toString());
    }
    return{'sales':sales,
    'totalEarnings':totalEarning};
  }


}
