import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({Key? key,required this.textInputType,required this.textEditingController,required this.hintText,this.isPass=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder=OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller:textEditingController ,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
      ),
      keyboardType:textInputType,
      obscureText:isPass,
    );
  }
}
