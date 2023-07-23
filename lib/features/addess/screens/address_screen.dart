
import 'package:amazon/Constant/utils.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';


import '../../../Constant/global_variable.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../Services/address_services.dart';

class Address extends StatefulWidget {
  final String totalamount;
  static const String routeName = '/address';
  const Address({Key? key, required this.totalamount}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItem = [];
  String addressToBeUsed="";
  final AddressServices addressServices=AddressServices() ;
  @override
  void initState() {

    super.initState();
    paymentItem.add(PaymentItem(
        amount: widget.totalamount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
  }

  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void ongpayPayresult(res) {

      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
      addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalamount));


  }
  void payPressed(String addressFromProvider){
    addressToBeUsed ="";
    bool   isForm=flatBuildingController.text.isNotEmpty||areaController.text.isNotEmpty||cityController.text.isNotEmpty||pincodeController.text.isNotEmpty;
    if(isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${flatBuildingController.text},${areaController.text},${cityController
            .text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the valuse!!!');
      } }else if (addressFromProvider.isNotEmpty) {
        addressToBeUsed=addressFromProvider;
    }
      else{
        Showsnackbar(context, 'ERROR');
    }
  }

  
@override
  Widget build(BuildContext context) {
    @override
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Globalariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    if (address.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                address,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    CustomTextFormField(
                      controller: flatBuildingController,
                      hinttext: 'Flat, House no ,Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: areaController,
                      hinttext: 'Area, Street',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: pincodeController,
                      hinttext: 'Pincode',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: cityController,
                      hinttext: 'Town/city',
                    ),
                  ],
                ),
              ),
              GooglePayButton(
                onPressed: ()=>payPressed(address),
                onPaymentResult: ongpayPayresult,
                paymentItems: paymentItem,
                paymentConfigurationAsset: 'gpay.json',
                height: 50,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
