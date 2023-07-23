import 'package:amazon/features/account/Services/account_services.dart';
import 'package:amazon/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

import '../../auth/screens/auth_screen.dart';


class TopButton extends StatelessWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Account_Button(text: 'Your Orders', ontap: (){},),
            Account_Button(text: 'Turn Sellers', ontap: (){},)
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
              Account_Button(text: 'Log Out', ontap:()=> AccountServices().logOut(context)),
            Account_Button(text: 'Your Wish List', ontap: (){
            },)
          ],
        )
      ],
    );
  }
}

