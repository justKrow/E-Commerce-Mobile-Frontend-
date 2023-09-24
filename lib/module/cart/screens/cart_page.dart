import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../../home/model/product_model.dart';
import '../bloc/cart_bloc/cart_management_bloc.dart';
import '../model/cart_list_model.dart';
import '../widget/cart_design.dart';
import '../widget/check_out_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

int totalPrice = 0;

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartManagementBloc>().add(CartListFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            LanguageManager.translate('cart'),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Are you sure?',
                        ),
                        content: const Text(
                          'Do you want to clean your cart?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.back(),
                            child: const Text(
                              'No',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.back();
                            },
                            child: const Text(
                              'Yes',
                            ),
                          ),
                        ],
                      );
                    }),
                child: Text(
                  LanguageManager.translate('clean'),
                  style: const TextStyle(
                    color: AppColor.redColor,
                  ),
                ))
          ],
        ),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(bottom: size.height * 0.13),
            child: BlocBuilder<CartManagementBloc, CartManagementState>(
              builder: (context, state) {
                if (state is CartManagementInitial) {
                  return const Center(
                    child: SpinKitCircle(color: AppColor.greenColor),
                  );
                } else if (state is CartFetchSuccessState) {
                  List<CartListModel> cartList = state.model;
                  return Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.02, bottom: size.height * 0.02),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CartListModel cart = cartList[index];
                          ProductModel productModel = cart.productModel!;
                          return cartDesign(size, productModel, context, cart);
                        }),
                  );
                } else if (state is CartListCachedState) {
                  List<CartListModel> cartList = state.model;
                  return Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.02, bottom: size.height * 0.02),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CartListModel cart = cartList[index];
                          ProductModel productModel = cart.productModel!;
                          return cartDesign(size, productModel, context, cart);
                        }),
                  );
                } else if (state is CartListEmptyState) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: size.height * 0.2,
                          child: Lottie.asset("assets/lottie/cart.json")),
                      const Padding(padding: EdgeInsets.all(10)),
                      const Text(
                        'Cart is Empty',
                        style: TextStyle(
                          color: AppColor.swatch,
                        ),
                      ),
                    ],
                  ));
                }
                return Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.2),
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/no_connection.json"),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        LanguageManager.translate('noConnection'),
                        style: const TextStyle(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          checkOutCart(size, context)
        ]));
  }
}
