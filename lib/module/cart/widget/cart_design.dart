import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../../home/model/product_model.dart';
import '../bloc/cart_bloc/cart_management_bloc.dart';
import '../model/cart_list_model.dart';

Container cartDesign(Size size, ProductModel productModel, BuildContext context,
    CartListModel cart) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        size.width * 0.05, 0, size.width * 0.05, size.height * 0.01),
    width: double.infinity,
    height: size.height * 0.15,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: AppColor.mildGreen,
          )
        ]),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Flexible(
        child: Swiper(
          autoplay: true,
          duration: 300,
          containerHeight: size.height * 0.13,
          itemCount: productModel.photos!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productModel.photos![index]))),
            );
          },
        ),
      ),
      SizedBox(
        width: size.width * 0.56,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<CartManagementBloc>()
                            .add(CartDeleteEvent(query: cart.id.toString()));
                        context
                            .read<CartManagementBloc>()
                            .add(CartListFetchEvent());
                      },
                      icon: const Icon(
                        IconlyLight.delete,
                        color: AppColor.redColor,
                        size: 20,
                      ))
                ],
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: LanguageManager.translate('quantity'),
                    style: const TextStyle()),
                const TextSpan(text: " - "),
                TextSpan(
                    text: cart.quantity.toString(), style: const TextStyle()),
              ])),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: LanguageManager.translate('totalPrice'),
                    style: const TextStyle()),
                const TextSpan(text: " - "),
                TextSpan(text: cart.totalPrice.toString()),
                const TextSpan(text: " "),
                TextSpan(
                    text: LanguageManager.translate('mmk'),
                    style: const TextStyle())
              ])),
            ],
          ),
        ),
      )
    ]),
  );
}
