import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:###/module/check_out/screens/check_out_page.dart';

import '../../module/auth/bloc/login/login_bloc.dart';
import '../../module/auth/bloc/sign_up/sign_up_bloc.dart';
import '../../module/auth/repo/auth_repo.dart';
import '../../module/auth/screens/auth_page.dart';
import '../../module/auth/screens/login_page.dart';
import '../../module/auth/screens/signup_page.dart';
import '../../module/cart/bloc/cart_bloc/cart_management_bloc.dart';
import '../../module/cart/repo/cart_repo.dart';
import '../../module/cart/screens/cart_page.dart';
import '../../module/check_out/bloc/check_out_bloc.dart';
import '../../module/home/bloc/banner/banner_bloc.dart';
import '../../module/home/bloc/product/product_bloc.dart';
import '../../module/home/repo/banner_fetch_repo.dart';
import '../../module/home/repo/product_fetch_repo.dart';
import '../../module/home/screens/home_page.dart';
import '../../module/home/screens/home_screen.dart';
import '../../module/profile/screens/profile_page.dart';
import '../../module/search/bloc/category/category_bloc.dart';
import '../../module/search/bloc/search/search_bloc.dart';
import '../../module/search/repo/category_fetch_repo.dart';
import '../../module/search/repo/search_fetch_repo.dart';
import '../../module/search/screens/search_page.dart';

class Routes {
  static const auth = "/";
  static const loginPage = "/loginPage";
  static const signupPage = "/signupPage";
  static const homeScreen = "/home";
  static const homePage = "/homePage";
  static const productDetailPage = "/productDetailPage";
  static const searchPage = "/searchPage";
  static const cartPage = "/cartPage";
  static const profilePage = "/profilePage";
  static const checkOutPage = "/checkOutPage";

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return makeRoute(const AuthPage(), settings);
      case loginPage:
        return makeRoute(
            BlocProvider(
              create: (context) => LoginBloc(AuthRepo()),
              child: const LoginPage(),
            ),
            settings);
      case signupPage:
        return makeRoute(
            BlocProvider(
              create: (context) => SignupBloc(AuthRepo()),
              child: const SignupPage(),
            ),
            settings);
      case homeScreen:
        return makeRoute(
            MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) =>
                    BannerBloc(BannerFetchRepo())..add(BannerFetchEvent()),
              ),
              BlocProvider(
                  create: (context) =>
                      CategoryBloc(CategoryRepo())..add(CategoryFetchEvent())),
              BlocProvider(
                  create: (context) => ProductBloc(ProductFetchRepo())
                    ..add(FetchProductEvent())),
              BlocProvider<SearchBloc>(
                  create: (context) => SearchBloc(SearchRepo())),
              BlocProvider<CartManagementBloc>(
                  create: (context) => CartManagementBloc(CartRepo())
                    ..add(CartListFetchEvent())),
            ], child: const HomeScreen()),
            settings);
      case homePage:
        return makeRoute(const HomePage(), settings);
      case searchPage:
        return makeRoute(const SearchPage(), settings);
      case cartPage:
        return makeRoute(const CartPage(), settings);
      case profilePage:
        return makeRoute(const ProfilePage(), settings);
      case checkOutPage:
        return makeRoute(
            BlocProvider(
              create: (context) => CheckOutBloc(),
              child: const CheckOutPage(),
            ),
            settings);
      default:
    }
    return null;
  }
}

Route? makeRoute(Widget widget, RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      return widget;
    },
    settings: settings,
  );
}
