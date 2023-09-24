import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class CheckOutTextFormField extends StatelessWidget {
  const CheckOutTextFormField({
    super.key,
    required this.controller,
    required this.size,
    required this.hintText,
    required this.maxLines,
    this.validator,
  });

  final TextEditingController controller;
  final Size size;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.mintGreen,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.02),
        fillColor: AppColor.scaffoldBackgroundColor,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greenColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greenColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.redColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.redColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
