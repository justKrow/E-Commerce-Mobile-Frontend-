import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:###/module/profile/screens/profile_page.dart';

import '../../../config/language/language_manager.dart';
import '../../../local_storage/shared_pref.dart';
import '../../../utils/color_constant.dart';
import '../../cart/screens/cart_page.dart';
import '../../search/screens/search_page.dart';
import '../widgets/side_bar.dart';
import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  List screen = [
    const HomePage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: pageIndex == 0 ? const SideMenu() : null,
        appBar: (pageIndex == 0)
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: AppColor.scaffoldBackgroundColor,
                centerTitle: true,
                title: Text(LanguageManager.translate('home'),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    )),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        icon: const Icon(
                          CupertinoIcons.cart,
                          color: AppColor.greenColor,
                        )),
                  )
                ],
              )
            : null,
        body: screen[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: "Profile"),
          ],
          backgroundColor: AppColor.activeIconColorLight,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(
              () => pageIndex = value,
            );
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColor.greenColor,
          selectedFontSize: 12,
          unselectedFontSize: 10,
        ),
      ),
    );
  }
}

String? userName;
String? phoneNumber;
String? email;
String? address;
String? city;
String? state;

void setUp() async {
  userName = await SharedPref.getStringValue(key: "userName") ?? "";
  phoneNumber = await SharedPref.getStringValue(key: "phone") ?? "";
  email = await SharedPref.getStringValue(key: "email") ?? "";
  address = await SharedPref.getStringValue(key: "address") ?? "";
  state = await SharedPref.getStringValue(key: "state");
  city = await SharedPref.getStringValue(key: "city");
}
