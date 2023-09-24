import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:###/config/routes/context_ext.dart';
import 'package:###/module/check_out/widgets/vertical_separator.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../utils/color_constant.dart';
import '../bloc/cart_bloc/cart_management_bloc.dart';
import '../screens/cart_page.dart';

Positioned checkOutCart(Size size, BuildContext context) {
  return Positioned(
    bottom: 10,
    left: size.width * 0.1,
    right: size.width * 0.1,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.greenColor,
      ),
      height: size.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LanguageManager.translate(
                      'totalPrice',
                    ),
                    style: const TextStyle(
                        color: AppColor.scaffoldBackgroundColor, fontSize: 12),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                  const Icon(
                    IconlyLight.buy,
                    color: AppColor.scaffoldBackgroundColor,
                    size: 15,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                  BlocBuilder<CartManagementBloc, CartManagementState>(
                    builder: (context, state) {
                      if (state is CartFetchSuccessState) {
                        return Text.rich(TextSpan(children: [
                          TextSpan(
                            text: totalPrice.toString(),
                            style: const TextStyle(
                                color: AppColor.scaffoldBackgroundColor),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: LanguageManager.translate('mmk'),
                            style: const TextStyle(
                                color: AppColor.scaffoldBackgroundColor,
                                fontSize: 12),
                          )
                        ]));
                      }
                      return Text.rich(TextSpan(children: [
                        const TextSpan(
                          text: '0',
                          style: TextStyle(
                              color: AppColor.scaffoldBackgroundColor),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: LanguageManager.translate('mmk'),
                          style: const TextStyle(
                              color: AppColor.scaffoldBackgroundColor,
                              fontSize: 12),
                        )
                      ]));
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const MyVerticalSeparator(
                color: AppColor.mildGreen,
              )
            ],
          ),
          InkWell(
            onTap: () {
              if (totalPrice > 0) {
                context.toName(Routes.checkOutPage);
              } else if (totalPrice == 0) {
                Dialogs.materialDialog(
                    msg: 'Add Items In Your Cart to Check Out',
                    title: "Empty Cart",
                    color: AppColor.mildGreen,
                    context: context,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {
                          context.back();
                        },
                        text: 'Ok',
                        color: AppColor.swatch,
                        iconData: Icons.cancel_outlined,
                        textStyle: const TextStyle(color: Colors.grey),
                        iconColor: Colors.grey,
                      ),
                    ]);
              }
            },
            child: Row(children: [
              Container(
                  margin: EdgeInsets.only(right: size.width * 0.1),
                  child: Text(
                    LanguageManager.translate('checkout'),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        wordSpacing: 1,
                        color: AppColor.scaffoldBackgroundColor),
                  )),
              const Icon(
                IconlyLight.arrow_right_circle,
                color: AppColor.scaffoldBackgroundColor,
              )
            ]),
          ),
        ],
      ),
    ),
  );
}
