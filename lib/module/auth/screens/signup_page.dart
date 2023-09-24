import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:###/config/routes/context_ext.dart';

import '../../../config/language/language_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/validator.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../bloc/sign_up/sign_up_event.dart';
import '../bloc/sign_up/sign_up_state.dart';
import '../model/sign_up_model.dart';
import '../widgets/custom_text_form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _registerKey = GlobalKey<FormState>();
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSussessState) {
          Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Your account has been verified',
              title: 'Congratulations',
              lottieBuilder: Lottie.asset(
                'assets/lottie/successTick.json',
                fit: BoxFit.contain,
              ),
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    context.toName(Routes.loginPage);
                  },
                  text: 'Login Now',
                  color: const Color.fromARGB(120, 20, 232, 50),
                  textStyle: const TextStyle(
                      color: AppColor.swatch, fontWeight: FontWeight.w500),
                  iconColor: Colors.white,
                ),
              ]);
        }
        if (state is SignupErrorState) {
          Dialogs.materialDialog(
              context: context,
              title: "Invalid",
              msg: state.message,
              actions: [
                IconsButton(
                  onPressed: () {
                    context.back();
                  },
                  text: 'ok',
                  color: const Color.fromARGB(120, 20, 232, 50),
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                ),
              ]);
        }
        if (state is SignupExceptionState) {
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
                      top: size.height * 0.1,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.2),
                              child: Text(
                                LanguageManager.translate('welcome'),
                                style: const TextStyle(
                                    color: AppColor.swatch,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.01),
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
              margin: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.35,
                  size.width * 0.1, size.height * 0.05),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.01),
                      child: Text(
                        LanguageManager.translate('createANewAccount'),
                        style: const TextStyle(
                            color: AppColor.swatch,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Form(
                      key: _registerKey,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomFormField(
                              controller: _nameController,
                              title: 'enterName',
                              validator: (value) =>
                                  Validator.nameValidate(value),
                              prefixWidget: Icon(
                                IconlyLight.profile,
                                color: AppColor.swatch.withOpacity(
                                  0.8,
                                ),
                              ),
                            ),
                            CustomFormField(
                              controller: _emailController,
                              title: 'enterEmail',
                              validator: (value) =>
                                  Validator.emailValidate(value),
                              prefixWidget: Icon(
                                IconlyLight.message,
                                color: AppColor.swatch.withOpacity(
                                  0.8,
                                ),
                              ),
                            ),
                            CustomFormField(
                              controller: _phoneController,
                              title: 'enterPhoneNumber',
                              validator: (value) =>
                                  Validator.phoneValidate(value),
                              prefixWidget: Icon(
                                IconlyLight.call,
                                color: AppColor.swatch.withOpacity(0.8),
                              ),
                            ),
                            CustomFormField(
                              controller: _passwordController,
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
                            CustomFormField(
                              controller: _retypePasswordController,
                              obscure: isObscure,
                              title: 'confirmPassword',
                              validator: (value) =>
                                  Validator.retypePasswordValidate(
                                      value, _passwordController.text),
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
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(120, 20, 232, 90),
                      ),
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.01),
                      width: size.width * 0.7,
                      height: size.height * 0.05,
                      child: TextButton(
                        onPressed: () {
                          var model = SignUpModel(
                              _nameController.text,
                              _emailController.text,
                              _phoneController.text,
                              _passwordController.text);
                          if (_registerKey.currentState?.validate() == true) {
                            context
                                .read<SignupBloc>()
                                .add(SignupCallEvent(model));
                          }
                        },
                        child: BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            if (state is SignupClickedState) {
                              return SpinKitFadingCircle(
                                size: size.width * 0.06,
                                color: AppColor.swatch,
                              );
                            }
                            return Text(
                              LanguageManager.translate("Register"),
                              style: const TextStyle(
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
                          LanguageManager.translate("alreadyHaveAnAccount?"),
                          style: const TextStyle(
                            color: AppColor.swatch,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              context.toName(Routes.loginPage);
                            },
                            child: Text(
                              LanguageManager.translate("login"),
                              style: const TextStyle(
                                  color: AppColor.greenColor,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        );
      },
    )));
  }
}
