import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:###/config/routes/context_ext.dart';
import 'package:###/local_storage/shared_pref.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../utils/color_constant.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/contact_us.dart';
import '../widgets/dashboard.dart';
import '../widgets/profile_photo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? profilePhotoPath;
  var titleSuggestionText = TextEditingController();
  var bodySuggestionText = TextEditingController();

  void loadProfilePhotoFromPrefs() async {
    final path = await SharedPref.getStringValue(key: 'profile_photo_key');
    setState(() {
      profilePhotoPath = path;
    });
  }

  Future<void> pickPhoto(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        profilePhotoPath = pickedImage.path;
      });
      await SharedPref.saveStringValue(
          key: 'profile_photo_key', value: profilePhotoPath!);
    }
  }

  @override
  void initState() {
    loadProfilePhotoFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.mildGreen,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(120, 20, 232, 50),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      topRight: Radius.circular(200))),
            ),
            Positioned(
                top: size.height * 0.05,
                bottom: size.height * 0.05,
                left: size.width * 0.1,
                right: size.width * 0.1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (profilePhotoPath == null)
                          ? InkWell(
                              onTap: () {
                                photoOption(context, size);
                              },
                              child: ProfilePhoto(
                                  size: size,
                                  profilePhotoPath: profilePhotoPath),
                            )
                          : InkWell(
                              onTap: () {
                                photoOption(context, size);
                              },
                              child: ProfilePhoto(
                                  size: size,
                                  profilePhotoPath: profilePhotoPath),
                            ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userName ?? 'Guest',
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.w500),
                            ),
                            const VerticalDivider(
                              color: AppColor.greenColor,
                              indent: 5,
                              endIndent: 5,
                              thickness: 1,
                            ),
                            const Icon(
                              IconlyLight.call,
                              size: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            FittedBox(
                              child: Text(
                                phoneNumber ?? '09123456789',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                          height: size.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                  child: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: LanguageManager.translate(
                                      'changeLanguage'),
                                  style: TextStyle(
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "  : ",
                                  style: TextStyle(
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]))),
                              SizedBox(
                                width: size.width * 0.15,
                                height: size.height * 0.08,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor:
                                            LanguageManager.currentLocale ==
                                                    'en_US'
                                                ? Colors.white
                                                : AppColor.swatch,
                                        backgroundColor:
                                            LanguageManager.currentLocale ==
                                                    'en_US'
                                                ? AppColor.greenColor
                                                : AppColor.mildGreen),
                                    onPressed: () {
                                      setState(() {
                                        LanguageManager.currentLocale = 'en_US';
                                      });
                                    },
                                    child: FittedBox(
                                        child: Text(
                                      'English',
                                      style: TextStyle(
                                          fontFamily:
                                              LanguageManager.currentLocale ==
                                                      'bu_MM'
                                                  ? null
                                                  : "GantGaw",
                                          fontWeight: FontWeight.w500),
                                    ))),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              SizedBox(
                                width: size.width * 0.15,
                                height: size.height * 0.08,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        LanguageManager.currentLocale = 'bu_MM';
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor:
                                            LanguageManager.currentLocale ==
                                                    'bu_MM'
                                                ? Colors.white
                                                : AppColor.swatch,
                                        backgroundColor:
                                            LanguageManager.currentLocale ==
                                                    'bu_MM'
                                                ? AppColor.greenColor
                                                : AppColor.mildGreen),
                                    child: const FittedBox(
                                        child: Text(
                                      'မြန်မာ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      DashBoard(
                          size: size,
                          titleSuggestionText: titleSuggestionText,
                          bodySuggestionText: bodySuggestionText),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColor,
                          ),
                          onPressed: () {
                            context.left(Routes.loginPage, (route) => false);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: size.height * 0.05,
                            child: Center(
                              child: Text(
                                LanguageManager.translate('logout'),
                                style: const TextStyle(
                                    color: AppColor.scaffoldBackgroundColor,
                                    fontSize: 15),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ContactUs(size: size)
                    ]))
          ],
        ),
      ),
    );
  }

  Future photoOption(BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                color: AppColor.mildGreen,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      LanguageManager.translate("selectAPhoto"),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Divider(
                      indent: size.width * 0.2,
                      endIndent: size.width * 0.2,
                      color: AppColor.greenColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              pickPhoto(ImageSource.camera);
                              context.back();
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  IconlyLight.camera,
                                  color: AppColor.greenColor,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  LanguageManager.translate("takeAPhoto"),
                                  style: const TextStyle(
                                      color: AppColor.greenColor),
                                ),
                              ],
                            )),
                        TextButton(
                            onPressed: () {
                              pickPhoto(ImageSource.gallery);
                              context.back();
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.category_outlined,
                                  color: AppColor.greenColor,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  LanguageManager.translate(
                                      "chooseFromGallery"),
                                  style: TextStyle(
                                      color: AppColor.greenColor,
                                      fontFamily:
                                          LanguageManager.currentLocale ==
                                                  'bu_MM'
                                              ? null
                                              : "GantGaw"),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ));
          });
        });
  }
}
