import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxlines;
  final String hinttext;
  const CustomTextFormField(
      {Key? key, required this.controller, required this.hinttext, this.maxlines=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please Enter $hinttext';
        }
        return null;
      },
      maxLines: maxlines,
    );
  }
}
