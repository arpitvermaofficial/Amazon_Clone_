import 'package:flutter/material.dart';

class Account_Button extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const Account_Button({Key? key, required this.text, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(primary: Colors.black12.withOpacity(0.03),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
            onPressed: ontap
          , child: Text(text,style:const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black
        ),))
      ),
    );
  }
}
