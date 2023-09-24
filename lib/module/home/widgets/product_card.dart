import 'package:flutter/material.dart';
import 'package:###/module/home/widgets/product_detail.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.018),
      decoration: BoxDecoration(
        color: AppColor.mildGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 1),
                    placeholder: NetworkImage(
                      productModel.photos![0],
                    ),
                    image: NetworkImage(
                      productModel.photos![0],
                    ),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: AppColor.greenColor,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: (productModel.producttype_name == "new")
                        ? AppColor.iosGreen
                        : (AppColor.iosYellow),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(
              size.width * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    productModel.name.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.swatch,
                        fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "${LanguageManager.translate('brand')} - ${(productModel.brand_name)} ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.swatch,
                        fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "${LanguageManager.translate('price')} - ${productModel.price.toString()} ${LanguageManager.translate('mmk')}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.swatch,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.greenColor),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  showProductDetail(context, productModel);
                },
                child: Text(LanguageManager.translate("seeMore"),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.scaffoldBackgroundColor)),
              ))
        ],
      ),
    );
  }
}
