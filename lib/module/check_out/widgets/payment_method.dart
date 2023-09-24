import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
    required this.size,
    required this.choosedPayment,
    this.photo,
    required this.choice,
    required this.name,
  });

  final Size size;
  final String? choosedPayment;
  final String? photo;
  final String? choice;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.32,
      height: size.height * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: (choosedPayment == choice)
            ? const Color.fromARGB(120, 20, 232, 50)
            : AppColor.scaffoldBackgroundColor,
      ),
      child: FittedBox(
        child: Row(
          children: [
            const SizedBox(width: 8),
            (photo != null)
                ? SizedBox(
                    width: size.width * 0.13,
                    child: Image.asset(photo ?? ""),
                  )
                : Container(),
            const SizedBox(width: 8),
            Text(
              name!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
