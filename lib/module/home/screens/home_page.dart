import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:###/module/home/model/product_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../bloc/banner/banner_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../model/product_type_declare.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var pageNumber = 0;
bool hasMorePage = true;

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  String paginationFooterText = '';
  String query = '';

  void _onLoading() async {
    pageNumber += 1;
    if (productType == "latest") {
      query = " ";
    } else {
      query = productType;
    }

    context.read<ProductBloc>().add(FetchMoreProductEvent(
        pageNumber: pageNumber, products: products, query: query));
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  void _onRefresh() async {
    productType = "latest";

    context.read<ProductBloc>().add(FetchProductEvent());

    if (mounted) {
      setState(() {});
    }
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(hasMorePage.toString());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
        if (state is ProductFetchSuccessState) {
          setState(() {
            hasMorePage = state.hasMorePage;
            pageNumber = state.currentPage;
          });

          log(hasMorePage.toString());
        }
      }, builder: (context, state) {
        return SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: hasMorePage,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          footer: CustomFooter(
            builder: (context, mode) {
              return const SizedBox(
                height: 30.0,
                child: Center(
                    child: SpinKitWave(
                  color: AppColor.greenColor,
                  size: 20,
                )),
              );
            },
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<BannerBloc, BannerState>(
                    builder: (context, state) {
                      if (state is BannerInitialState) {
                        return Center(
                          child: SpinKitCircle(
                              color: AppColor.greenColor,
                              size: size.height * 0.05),
                        );
                      }
                      if (state is BannerFetchedState) {
                        return SizedBox(
                            height: size.height * 0.23,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  state.imgUrls[index],
                                  fit: BoxFit.fill,
                                );
                              },
                              itemCount: state.imgUrls.length,
                              viewportFraction: 0.8,
                              scale: 0.9,
                              pagination: SwiperPagination(
                                  builder: SwiperCustomPagination(
                                builder: (context, config) {
                                  return ConstrainedBox(
                                    constraints: const BoxConstraints.expand(
                                        height: 30.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: const DotSwiperPaginationBuilder(
                                                    color: AppColor
                                                        .activeIconColorLight,
                                                    activeColor: AppColor
                                                        .disableIconColorDark,
                                                    size: 8.0,
                                                    activeSize: 10.0)
                                                .build(context, config),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )),
                            ));
                      }
                      if (state is BannerErrorState) {
                        return const Center(
                          child: Text(
                            'No images to display',
                          ),
                        );
                      }
                      return const Center(
                        child: Text(
                          'Something went wrong',
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.greenColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.27,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                productType = "new";
                              });
                              context
                                  .read<ProductBloc>()
                                  .add(FetchNewProductEvent());
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: productType == "new"
                                    ? Colors.white
                                    : AppColor.swatch,
                                backgroundColor: productType == "new"
                                    ? AppColor.greenColor
                                    : AppColor.scaffoldBackgroundColor),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    LanguageManager.translate('newProducts'),
                                    style: const TextStyle(),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColor.greenColor,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: AppColor.iosGreen,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(FetchProductEvent());

                              setState(() {
                                productType = "latest";
                              });
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: productType == "latest"
                                    ? Colors.white
                                    : AppColor.swatch,
                                backgroundColor: productType == "latest"
                                    ? AppColor.greenColor
                                    : AppColor.scaffoldBackgroundColor),
                            child: Text(
                              LanguageManager.translate('latest'),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.27,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                productType = "second";
                              });
                              context
                                  .read<ProductBloc>()
                                  .add(FetchSeccondHandProductEvent());
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: productType == "second"
                                    ? Colors.white
                                    : AppColor.swatch,
                                backgroundColor: productType == "second"
                                    ? AppColor.greenColor
                                    : AppColor.scaffoldBackgroundColor),
                            child: FittedBox(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColor.greenColor,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: AppColor.iosYellow,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(LanguageManager.translate('secondHand'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitialState) {
                        return Center(
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, size.height * 0.3, 0, 0),
                            child: SpinKitCircle(
                              color: AppColor.greenColor,
                              size: size.height * 0.05,
                            ),
                          ),
                        );
                      }

                      if (state is ProductFetchSuccessState) {
                        products = state.products;
                        return StaggeredGrid.count(
                          crossAxisCount:
                              MediaQuery.of(context).size.width <= 400.0
                                  ? 2
                                  : MediaQuery.of(context).size.width >= 1000.0
                                      ? 4
                                      : 3,
                          mainAxisSpacing: size.width * 0.02,
                          crossAxisSpacing: size.width * 0.02,
                          children: products.map((data) {
                            return ProductCard(
                              productModel: data,
                            );
                          }).toList(),
                        );
                      }
                      if (state is ProductFetchEmptyState) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.01),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: size.width * 0.02,
                            crossAxisSpacing: size.width * 0.03,
                            children: products.map((data) {
                              return ProductCard(
                                productModel: data,
                              );
                            }).toList(),
                          ),
                        );
                      }
                      if (state is ProductErrorState) {
                        return const Center(
                          child: Text(
                            'Shop is empty',
                          ),
                        );
                      }
                      return Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.3),
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
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
