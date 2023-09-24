import 'package:flutter/material.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;
  final bool? obscure;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.title,
    this.suffixWidget,
    this.prefixWidget,
    this.obscure,
    this.validator,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
          width: double.infinity,
          child: TextFormField(
            obscureText: obscure ?? false,
            validator: validator,
            cursorColor: AppColor.yelloGreen,
            style: TextStyle(
              fontFamily:
                  LanguageManager.currentLocale == 'bu_MM' ? null : "GantGaw",
              fontSize: 13,
              color: AppColor.swatch,
            ),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              helperMaxLines: 5,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.greenColor),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.greenColor),
                  borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.redColor),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.redColor),
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: AppColor.scaffoldBackgroundColor,
              contentPadding: const EdgeInsets.all(0),
              hintText: hintText,
              label: Text(
                LanguageManager.translate(title),
                style: TextStyle(
                  fontFamily: LanguageManager.currentLocale == 'bu_MM'
                      ? null
                      : "GantGaw",
                  color: AppColor.swatch.withOpacity(
                    0.9,
                  ),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              suffixIcon: suffixWidget,
              prefixIcon: prefixWidget,
            ),
          ),
        ),
      ],
    );
  }
}
