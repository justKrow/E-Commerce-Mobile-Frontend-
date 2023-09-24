import 'package:flutter/material.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../utils/color_constant.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      child: Image.asset(
                        'assets/images/phoneuser.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.01),
                      child: Text(
                        LanguageManager.translate('MyaitZimonYin'),
                        style: const TextStyle(
                          color: AppColor.greenColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.01),
                      child: Text(
                        LanguageManager.translate('welcomeToTheApp'),
                        style: const TextStyle(
                          color: AppColor.swatch,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor:
                                        LanguageManager.currentLocale == 'en_US'
                                            ? Colors.white
                                            : AppColor.disableIconColorDark,
                                    backgroundColor:
                                        LanguageManager.currentLocale == 'en_US'
                                            ? AppColor.greenColor
                                            : AppColor.scaffoldBackgroundColor),
                                onPressed: () {
                                  setState(() {
                                    LanguageManager.currentLocale = 'en_US';
                                  });
                                },
                                child: const Text(
                                  'English',
                                )),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    LanguageManager.currentLocale = 'bu_MM';
                                  });
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor:
                                        LanguageManager.currentLocale == 'bu_MM'
                                            ? Colors.white
                                            : AppColor.disableIconColorDark,
                                    backgroundColor:
                                        LanguageManager.currentLocale == 'bu_MM'
                                            ? AppColor.greenColor
                                            : AppColor.scaffoldBackgroundColor),
                                child: const Text(
                                  'မြန်မာ',
                                )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.32,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                context.toName(Routes.loginPage);
                              },
                              child: Text(
                                LanguageManager.translate('login'),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.scaffoldBackgroundColor),
                              )),
                        ),
                        Container(
                          width: size.width * 0.32,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.greenColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                context.toName(Routes.signupPage);
                              },
                              child: Text(
                                LanguageManager.translate('register'),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.greenColor),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
