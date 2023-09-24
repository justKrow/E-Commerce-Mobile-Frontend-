import 'package:flutter/material.dart';
import 'package:###/utils/color_constant.dart';

import '../../../config/language/language_manager.dart';

class ProductDataRows extends StatelessWidget {
  const ProductDataRows({
    super.key,
    required this.size,
    required this.data,
    required this.name,
  });

  final Size size;
  final String data;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.03,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(LanguageManager.translate(name)),
          Text(
            data,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColor.greenColor),
          )
        ],
      ),
    );
  }
}
