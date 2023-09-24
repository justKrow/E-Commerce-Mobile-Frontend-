import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';
import '../../home/model/product_model.dart';
import '../../home/screens/home_page.dart';
import '../../home/widgets/product_card.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchTitle;
  var searchQuery = TextEditingController();
  List<ProductModel> products = [];
  final RefreshController _refreshController = RefreshController();
  bool hasMorePage = true;
  String paginationFooterText = '';
  void _onLoading() async {
    pageNumber += 1;

    context.read<SearchBloc>().add(SearchMoreProductEvent(
        pageNumber: pageNumber, products: products, query: searchTitle ?? " "));
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.scaffoldBackgroundColor,
        title: SizedBox(
          height: size.height * 0.05,
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              pageNumber = 1;
              context.read<SearchBloc>().add(SearchCallEvent(value));
              searchTitle = value;
            },
            controller: searchQuery,
            style: const TextStyle(color: AppColor.swatch),
            cursorColor: AppColor.iosGreen,
            decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(0),
                fillColor: AppColor.mildGreen,
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: AppColor.swatch,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchQuery.clear();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    CupertinoIcons.xmark_circle,
                    color: AppColor.swatch,
                    size: 20,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintText: LanguageManager.translate('searchinshop'),
                hintStyle: const TextStyle(
                  color: AppColor.swatch,
                )),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  pageNumber = 1;
                  context
                      .read<SearchBloc>()
                      .add(SearchCallEvent(searchQuery.text));
                  searchTitle = searchQuery.text;
                });
              },
              child: Text(
                LanguageManager.translate('search'),
                style: const TextStyle(
                    color: AppColor.swatch, fontWeight: FontWeight.w500),
              ))
        ],
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchLoadedState) {
            hasMorePage = state.hasMorePage;
            pageNumber = state.currentPage;
          }
          if (state is SearchExceptionState) {
            Dialogs.materialDialog(
              context: context,
              title: "Server Error",
              titleStyle: const TextStyle(),
              msg: "${state.exception.failture.message} ",
              msgStyle: const TextStyle(),
              actions: [
                TextButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(
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
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Chip(
                    backgroundColor: AppColor.mildGreen,
                    label: Text(
                      LanguageManager.translate('category'),
                      style: const TextStyle(),
                    ),
                    avatar: const Icon(
                      IconlyLight.category,
                      color: AppColor.greenColor,
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitialState) {
                        return Center(
                          child: SpinKitCircle(
                              color: AppColor.greenColor,
                              size: size.height * 0.05),
                        );
                      }
                      if (state is CategoryFetchedState) {
                        return SizedBox(
                          width: double.infinity,
                          height: size.height * 0.15,
                          child: GridView.builder(
                              itemCount: state.categories.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 100,
                                      childAspectRatio: 1.5 / 2.5,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.read<SearchBloc>().add(
                                        SearchCallEvent(
                                            state.categories[index].name!));
                                    setState(() {
                                      searchTitle =
                                          state.categories[index].name!;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    width: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              state.categories[index].photo!),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.28),
                                              BlendMode.dstATop)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      '${state.categories[index].name}',
                                      style: TextStyle(
                                          fontFamily:
                                              LanguageManager.currentLocale ==
                                                      'bu_MM'
                                                  ? null
                                                  : "GantGaw",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    )),
                                  ),
                                );
                              }),
                        );
                      }
                      return Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: size.height) * 0.01,
                    margin: EdgeInsets.symmetric(vertical: size.height) * 0.02,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.mildGreen,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ((searchTitle == null))
                              ? "Search result for  :    ' ' "
                              : "Search result for  :    ' $searchTitle '",
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchInitialState) {
                          return Center(
                            child: Container(
                              child: Lottie.asset(
                                'assets/lottie/contact_us.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }
                        if (state is SearchEmptyState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: size.width * 0.6,
                                  height: size.height * 0.4,
                                  child: Lottie.asset(
                                    'assets/lottie/shake_empty_box.json',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: Text(
                                LanguageManager.translate('nosearchresult'),
                                style: const TextStyle(),
                              ))
                            ],
                          );
                        }
                        if (state is SearchLoadingState) {
                          return Center(
                            child: Container(
                              child: Lottie.asset(
                                'assets/lottie/searching.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }
                        if (state is SearchLoadedState) {
                          products = state.products;
                          hasMorePage = state.hasMorePage;
                          pageNumber = state.currentPage;
                          return SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: false,
                            enablePullUp: hasMorePage,
                            onLoading: _onLoading,
                            footer: CustomFooter(
                              builder: (context, mode) {
                                return const SizedBox(
                                  height: 30.0,
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: SpinKitWave(
                                      color: AppColor.greenColor,
                                      size: 15,
                                    ),
                                  )),
                                );
                              },
                            ),
                            child: MasonryGridView.builder(
                                itemCount: products.length,
                                mainAxisSpacing: size.width * 0.02,
                                crossAxisSpacing: size.width * 0.02,
                                gridDelegate:
                                    SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width <= 400.0
                                          ? 2
                                          : MediaQuery.of(context).size.width >=
                                                  1000.0
                                              ? 4
                                              : 3,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final product = products[index];
                                  return ProductCard(productModel: product);
                                }),
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
                    ),
                  )
                ]),
          );
        },
      ),
    );
  }
}
