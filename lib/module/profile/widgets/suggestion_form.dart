import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../utils/color_constant.dart';

class SuggestionForm extends StatelessWidget {
  const SuggestionForm({
    super.key,
    required this.size,
    required this.titleSuggestionText,
    required this.bodySuggestionText,
  });

  final Size size;
  final TextEditingController titleSuggestionText;
  final TextEditingController bodySuggestionText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppColor.scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  LanguageManager.translate("suggestform"),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const Divider(),
              Text(
                LanguageManager.translate('entertitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                height: size.height * 0.05,
                child: Center(
                  child: TextField(
                    controller: titleSuggestionText,
                    decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: size.width * 0.02),
                        fillColor: AppColor.mildGreen,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Delivery request",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(105, 40, 40, 40))),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                LanguageManager.translate("entersuggestion"),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                child: TextField(
                  controller: bodySuggestionText,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.02),
                      fillColor: AppColor.mildGreen,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Delivery to yangon",
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(105, 40, 40, 40))),
                  maxLines: 10,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.scaffoldBackgroundColor,
                        border: Border.all(color: AppColor.greenColor)),
                    child: TextButton(
                        onPressed: () {
                          titleSuggestionText.clear();
                          bodySuggestionText.clear();
                          context.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              LanguageManager.translate('cancel'),
                              style: const TextStyle(
                                color: AppColor.redColor,
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.xmark_circle,
                              color: AppColor.redColor,
                              size: 15,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.greenColor,
                    ),
                    child: TextButton(
                        onPressed: () {
                          titleSuggestionText.clear();
                          bodySuggestionText.clear();
                          Dialogs.materialDialog(
                              color: Colors.white,
                              title:
                                  LanguageManager.translate('sentSuccessfully'),
                              titleStyle: const TextStyle(),
                              lottieBuilder: Lottie.asset(
                                'assets/lottie/mail_send.json',
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
                                  textStyle: TextStyle(
                                      fontFamily:
                                          LanguageManager.currentLocale ==
                                                  'bu_MM'
                                              ? null
                                              : "GantGaw",
                                      color: AppColor.scaffoldBackgroundColor,
                                      fontWeight: FontWeight.w500),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              LanguageManager.translate('send'),
                              style: const TextStyle(
                                  color: AppColor.scaffoldBackgroundColor),
                            ),
                            const Icon(
                              IconlyLight.send,
                              color: AppColor.scaffoldBackgroundColor,
                              size: 15,
                            )
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
