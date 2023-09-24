import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../local_storage/shared_pref.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dialog_service.dart';
import '../../../utils/validator.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/login/login_bloc.dart';
import '../model/login_model.dart';
import '../widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  bool isRememberMe = false;
  bool isObscure = false;
  @override
  void initState() {
    setUp();
    super.initState();
    readFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginInitialState) {
            DialogActions.showLoaderDialog(context);
          }
          if (state is LoginSuccessState) {
            context.back();
            context.left(Routes.homeScreen, (route) => false);
          }
          if (state is LoginErrorState) {
            Dialogs.materialDialog(
                context: context,
                title: "Invalid",
                msg: "Check your Phone Number and Password again",
                actions: [
                  IconsButton(
                    onPressed: () {
                      context.back();
                    },
                    text: 'ok',
                    color: AppColor.greenColor,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    iconColor: Colors.white,
                  ),
                ]);
          }
          if (state is LoginExceptionState) {
            Dialogs.materialDialog(
              context: context,
              title: "Server Error",
              msg:
                  "${state.exception.failture.message} ${state.exception.failture.reason}",
              actions: [
                TextButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      color: AppColor.swatch,
                    ),
                  ),
                  onPressed: () {
                    context.back();
                  },
                ),
              ],
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(children: [
              SizedBox(
                  height: size.height * 0.5,
                  child: Stack(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                        color: Color.fromARGB(120, 20, 232, 50),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      )),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: size.height * 0.16,
                        child: Column(
                          children: [
                            Text(
                              LanguageManager.translate('welcomeBack'),
                              style: const TextStyle(
                                  color: AppColor.swatch,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    const AssetImage("assets/images/logo.png"),
                                radius: size.height * 0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.scaffoldBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: AppColor.mildGreen,
                      )
                    ]),
                margin: EdgeInsets.fromLTRB(
                    size.width * 0.1, size.height * 0.4, size.width * 0.1, 0),
                child: Form(
                    key: _loginKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1,
                                vertical: size.height * 0.01),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: AppColor.swatch,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomFormField(
                                controller: phoneController,
                                title: 'enterPhoneNumber',
                                validator: (value) =>
                                    Validator.phoneValidate(value),
                                prefixWidget: Icon(
                                  IconlyLight.call,
                                  color: AppColor.swatch.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomFormField(
                                controller: passwordController,
                                title: 'enterPassword',
                                obscure: isObscure,
                                validator: (value) =>
                                    Validator.passwordValidate(value),
                                prefixWidget: Icon(
                                  IconlyLight.password,
                                  color: AppColor.swatch.withOpacity(
                                    0.8,
                                  ),
                                ),
                                suffixWidget: IconButton(
                                  icon: Icon(
                                    color: AppColor.swatch,
                                    isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 23,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1,
                                child: Checkbox(
                                  activeColor: AppColor.swatch,
                                  value: isRememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      isRememberMe = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              Text(
                                LanguageManager.translate('rememberMe'),
                                style: const TextStyle(
                                  color: AppColor.swatch,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(120, 20, 232, 90),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: size.width * 0.01),
                            width: size.width * 0.7,
                            height: size.height * 0.05,
                            child: TextButton(
                              onPressed: () {
                                var model = LoginModel(
                                    userName!,
                                    email!,
                                    phoneController.text,
                                    passwordController.text);
                                if (_loginKey.currentState?.validate() ==
                                    true) {
                                  context
                                      .read<LoginBloc>()
                                      .add(LoginCallEvent(model, isRememberMe));
                                }
                              },
                              child: BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginClickedState) {
                                    return SpinKitFadingCircle(
                                      size: size.width * 0.06,
                                      color: AppColor.swatch,
                                    );
                                  }
                                  return const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColor.swatch,
                                        fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                LanguageManager.translate(
                                    "dont'tHaveAnAccount?"),
                                style: const TextStyle(
                                  color: AppColor.swatch,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.toName(Routes.signupPage);
                                  },
                                  child: Text(
                                    LanguageManager.translate("registerNow"),
                                    style: const TextStyle(
                                        color: AppColor.greenColor,
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ]),
          );
        },
      ),
    ));
  }

  Future<void> readFromStorage() async {
    isRememberMe = await SharedPref.getBoolValue(key: 'isRememberMe') ?? false;
    if (isRememberMe) {
      phoneController.text =
          await SharedPref.getStringValue(key: 'phone') ?? '';
      passwordController.text =
          await SharedPref.getStringValue(key: "password") ?? '';
    }
    setState(() {});
  }
}
