import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile(
      {super.key,
      required this.size,
      required this.icon,
      required this.text,
      required this.onPressed});

  final Size size;
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.mildGreen,
          ),
          height: size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              FittedBox(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
    );
  }
}
