import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../utils/color_constant.dart';
import '../bloc/product/product_bloc.dart';
import '../model/product_type_declare.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    context.back();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 25,
                  ))
            ],
          ),
          ListTile(
            leading: TextButton(
                onPressed: () {
                  context.back();
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.black,
              colorScheme: const ColorScheme.light(
                primary: AppColor.greenColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ExpansionTile(
                title: const Text(''),
                leading: const Text('Shop Now',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
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
                                  : AppColor.disableIconColorDark,
                              backgroundColor: productType == "latest"
                                  ? AppColor.greenColor
                                  : AppColor.scaffoldBackgroundColor),
                          child: const Text(
                            'Latest',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
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
                                  : AppColor.disableIconColorDark,
                              backgroundColor: productType == "new"
                                  ? AppColor.greenColor
                                  : AppColor.scaffoldBackgroundColor),
                          child: const Text(
                            'Brand New',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
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
                                  : AppColor.disableIconColorDark,
                              backgroundColor: productType == "second"
                                  ? AppColor.greenColor
                                  : AppColor.scaffoldBackgroundColor),
                          child: const Text('Second Hand',
                              style: TextStyle(
                                fontSize: 13,
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: TextButton(
                onPressed: () {},
                child: const Text(
                  'Privacy & Policy',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
          ),
          ListTile(
            leading: TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
