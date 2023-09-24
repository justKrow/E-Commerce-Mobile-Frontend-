import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:###/config/routes/context_ext.dart';
import 'package:###/module/home/widgets/product_data_rows.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../../cart/bloc/cart_bloc/cart_management_bloc.dart';
import '../../cart/model/cart_model.dart';
import '../../cart/repo/cart_repo.dart';
import '../model/product_model.dart';

Future<dynamic> showProductDetail(BuildContext context, ProductModel data) {
  final SwiperController swiperController = SwiperController();
  var size = MediaQuery.of(context).size;
  int count = 1;
  int? totalPrice;
  return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => CartManagementBloc(CartRepo()),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Scaffold(
                backgroundColor: AppColor.mildGreen,
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: AppColor.scaffoldBackgroundColor,
                  centerTitle: true,
                  title: Text(LanguageManager.translate('detail'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      )),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.3,
                        child: Swiper(
                          controller: swiperController,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage(
                                fadeInDuration: const Duration(milliseconds: 1),
                                placeholder: NetworkImage(
                                  data.photos![index].toString(),
                                ),
                                image: NetworkImage(
                                  data.photos![index].toString(),
                                ),
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Image(
                                    image: AssetImage("assets/images/logo.png"),
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            );
                          },
                          viewportFraction: 0.8,
                          scale: 0.9,
                          itemCount: data.photos!.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: data.photos!.map((String url) {
                            int index = data.photos!.indexOf(url);

                            return GestureDetector(
                              onTap: () {
                                swiperController.move(index);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                width: size.width * 0.12,
                                height: size.width * 0.12,
                                child: FadeInImage(
                                  fadeInDuration:
                                      const Duration(milliseconds: 1),
                                  placeholder:
                                      const AssetImage("assets/image/logo.png"),
                                  image: NetworkImage(url),
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return const Image(
                                      image:
                                          AssetImage("assets/images/logo.png"),
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColor.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(90),
                                topRight: Radius.circular(90))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.5,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.mildGreen,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: FittedBox(
                                  child: Text(
                                    data.name.toString(),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  width: size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ProductDataRows(
                                        size: size,
                                        data: data.brand_name.toString(),
                                        name: 'brand',
                                      ),
                                      ProductDataRows(
                                        size: size,
                                        data: data.category_name.toString(),
                                        name: 'category',
                                      ),
                                      ProductDataRows(
                                        size: size,
                                        data: data.producttype_name.toString(),
                                        name: 'quality',
                                      ),
                                      ProductDataRows(
                                        size: size,
                                        data: data.size.toString(),
                                        name: 'size',
                                      ),
                                      ProductDataRows(
                                        size: size,
                                        data:
                                            "${data.price.toString()} ${LanguageManager.translate('mmk')}",
                                        name: 'price',
                                      ),
                                      ProductDataRows(
                                        size: size,
                                        data: data.stock.toString(),
                                        name: 'instock',
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.04,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 234, 233, 235),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: FittedBox(
                                    child: Text(
                                      LanguageManager.translate(
                                        'description',
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    color: AppColor.mildGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '${data.detail}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: AppColor.mildGreen,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: (totalPrice ?? data.price!)
                                            .toString(),
                                        style: const TextStyle(
                                            color: AppColor.swatch,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${LanguageManager.translate('mmk')} ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ])),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (count == 1) {
                                                null;
                                              } else {
                                                setState(
                                                  () {
                                                    count--;
                                                    totalPrice =
                                                        count * data.price!;
                                                  },
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              CupertinoIcons.minus_rectangle,
                                              color: (count == 1)
                                                  ? Colors.grey
                                                  : AppColor.redColor,
                                              size: 20,
                                            )),
                                        Text(
                                          count.toString(),
                                          style: TextStyle(
                                              fontFamily: LanguageManager
                                                          .currentLocale ==
                                                      'bu_MM'
                                                  ? null
                                                  : "GantGaw",
                                              color: AppColor.swatch),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (count == data.stock) {
                                                null;
                                              } else {
                                                setState(
                                                  () {
                                                    count++;
                                                    totalPrice =
                                                        count * data.price!;
                                                  },
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              CupertinoIcons.plus_rectangle,
                                              color: (count == data.stock)
                                                  ? Colors.grey
                                                  : AppColor.greenColor,
                                              size: 20,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.greenColor),
                                child: TextButton(
                                    onPressed: () {
                                      var model = CartModel(
                                          quantity: count, product_id: data.id);
                                      context
                                          .read<CartManagementBloc>()
                                          .add(CartAddEvent(model: model));
                                    },
                                    child: BlocConsumer<CartManagementBloc,
                                        CartManagementState>(
                                      listener: (context, state) {
                                        if (state is CartAddSuccessState) {
                                          Dialogs.materialDialog(
                                              color: Colors.white,
                                              title: 'Added to Cart',
                                              titleStyle: const TextStyle(),
                                              lottieBuilder: Lottie.asset(
                                                'assets/lottie/cartAdd.json',
                                                fit: BoxFit.contain,
                                              ),
                                              context: context,
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    context.back();
                                                    context.back();
                                                  },
                                                  text: 'done',
                                                  color: AppColor.greenColor,
                                                  textStyle: const TextStyle(
                                                      color: AppColor
                                                          .scaffoldBackgroundColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  iconColor: Colors.white,
                                                ),
                                              ]);
                                        } else if (state is CartErrorState) {
                                          Dialogs.materialDialog(
                                              context: context,
                                              title: "Invalid",
                                              msg: state.message,
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    context.back();
                                                  },
                                                  text: 'ok',
                                                  color: const Color.fromARGB(
                                                      120, 20, 232, 50),
                                                  textStyle: const TextStyle(
                                                      fontFamily: "GantGaw",
                                                      color: Colors.white),
                                                  iconColor: Colors.white,
                                                ),
                                              ]);
                                        } else if (state
                                            is CartExceptionState) {
                                          Dialogs.materialDialog(
                                            context: context,
                                            title: "Server Error",
                                            titleStyle: const TextStyle(),
                                            msg:
                                                "${state.exception.failture.message} ",
                                            msgStyle: const TextStyle(),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                    fontFamily: LanguageManager
                                                                .currentLocale ==
                                                            'bu_MM'
                                                        ? null
                                                        : "GantGaw",
                                                    color: AppColor.swatch,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return Text(
                                          LanguageManager.translate(
                                              'addtocart'),
                                          style: TextStyle(
                                              fontFamily: LanguageManager
                                                          .currentLocale ==
                                                      'bu_MM'
                                                  ? null
                                                  : "GantGaw",
                                              color: AppColor
                                                  .scaffoldBackgroundColor),
                                        );
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
}
