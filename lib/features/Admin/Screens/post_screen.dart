import 'package:amazon/features/Admin/Screens/add_product.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:amazon/features/Admin/Admin_Services/admin_services.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products = [];
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
     super.initState();
    fetchAllproduct();

  }

  fetchAllproduct() async {
      products = await adminServices.fetchAllproduct(context);
    setState(() {});
  }


  void navigateToAddProduct() {
    Navigator.pushNamed(context, Add_Product.routename);
  }
  void deleteProduct(Product product,int index){
    adminServices.deleteProduct(context: context, product: product, onSuccess:(){
      products!.removeAt(index);
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: navigateToAddProduct,
            ),
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                final productData = products![index];
                print(products![index].images[0]);
                return Column(
                  children: [
                    SingleProduct(
                      image: productData.images[0],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                        IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            }, icon: Icon(Icons.delete_outline))
                      ],
                    ),

                  ],
                );
              },
            ));
  }
}
