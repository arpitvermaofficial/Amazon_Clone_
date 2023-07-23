import 'dart:io';

import 'package:amazon/common/widgets/Custom_Buttom.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/features/Admin/Admin_Services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../Constant/global_variable.dart';
import '../../../Constant/utils.dart';

class Add_Product extends StatefulWidget {
  static const String routename = '/addproduct';
  const Add_Product({Key? key}) : super(key: key);

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  final TextEditingController productcontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantittycontroller = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String category = 'Mobiles';
  @override
  void dispose() {
    // TODO: implement dispose
    productcontroller.dispose();
    pricecontroller.dispose();
    quantittycontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  List<String> productCategoriees = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productcontroller.text,
          description: descriptioncontroller.text,
          price: double.parse(pricecontroller.text),
          quantity: double.parse(quantittycontroller.text),
          category: category,
          images: images);
    }
  }

  void selectimages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Globalariables.appBarGradient),
          ),
          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200))
                    : GestureDetector(
                        onTap: () {
                          selectimages();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                    controller: productcontroller, hinttext: 'Product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: descriptioncontroller,
                  hinttext: 'Description',
                  maxlines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: pricecontroller, hinttext: 'Price'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: quantittycontroller, hinttext: 'Quantity'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    icon: Icon(Icons.arrow_downward),
                    onChanged: (String? newval) {
                      setState(() {
                        category = newval!;
                      });
                    },
                    value: category,
                    items: productCategoriees.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    text: 'Sell',
                    onTap: () {
                      sellProduct();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
