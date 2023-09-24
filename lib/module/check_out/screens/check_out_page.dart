import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:###/config/language/language_manager.dart';
import 'package:###/config/routes/context_ext.dart';
import 'package:###/module/cart/screens/cart_page.dart';
import 'package:###/module/check_out/model/payment_model.dart';
import 'package:###/module/check_out/widgets/check_out_textform.dart';
import 'package:###/module/home/screens/home_screen.dart';
import 'package:###/utils/color_constant.dart';

import '../../../utils/validator.dart';
import '../bloc/check_out_bloc.dart';
import '../widgets/payment_method.dart';
import '../widgets/sperator.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  bool clicked = false;
  bool isRememberAddress = false;
  String? selectedState;
  String? selectedCity;
  String? choosedPayment;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  final _checkOutKey = GlobalKey<FormState>();

  List<String> myanmarStates = [
    'Ayeyarwady',
    'Bago',
    'Chin',
    'Kachin',
    'Kayah',
    'Kayin',
    'Magway',
    'Mandalay',
    'Mon',
    'Rakhine',
    'Sagaing',
    'Shan',
    'Tanintharyi',
    'Yangon'
  ];
  List<String> myanmarCities = [
    'Sanchaung',
    'Bahan',
    'Kamayut',
    'Ahlone',
    'Mayangone',
    'Hlaing',
    'Kyauktada',
    'Lanmadaw',
    'Mingala Taungnyunt',
    'Thingangyun',
    'South Okkalapa',
    'North Okkalapa',
    'Dagon',
    'Insein',
    'Shwepyitha',
  ];

  @override
  void initState() {
    super.initState();
    nameController.text = userName.toString();
    phoneController.text = phoneNumber.toString();
    addressController.text = address.toString();
    if (city != null && city != "") {
      int cityIndex = myanmarCities.indexOf(city!);
      selectedCity = myanmarCities[cityIndex];
    }
    if (state != null && state != "") {
      int stateIndex = myanmarStates.indexOf(state!);
      selectedState = myanmarStates[stateIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mildGreen,
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          foregroundColor: AppColor.swatch,
          elevation: 0,
          centerTitle: true,
          title: Text(LanguageManager.translate('checkout')),
        ),
        body: BlocConsumer<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state is CheckOutKpayState) {
              choosedPayment = "KBZPay";
            }
            if (state is CheckOutWavePayState) {
              choosedPayment = "WavePay";
            }
            if (state is CheckOutCashOnDeliveryState) {
              choosedPayment = "Cash On Delivery";
            }
            if (state is CheckOutSuccessState) {
              Dialogs.materialDialog(
                  color: Colors.white,
                  title: 'Order Successful',
                  titleStyle: const TextStyle(),
                  lottieBuilder: Lottie.asset(
                    'assets/lottie/thank-you.json',
                    fit: BoxFit.contain,
                  ),
                  context: context,
                  actions: [
                    IconsButton(
                      onPressed: () {
                        context.back();
                        context.back();
                        context.back();
                      },
                      text: 'done',
                      color: AppColor.greenColor,
                      textStyle: const TextStyle(
                          color: AppColor.scaffoldBackgroundColor,
                          fontWeight: FontWeight.w500),
                      iconColor: Colors.white,
                    ),
                  ]);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Form(
                        key: _checkOutKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              LanguageManager.translate('enterName'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            CheckOutTextFormField(
                                validator: (value) =>
                                    Validator.nameValidate(value),
                                controller: nameController,
                                size: size,
                                hintText: userName.toString(),
                                maxLines: 1),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              LanguageManager.translate('enterPhoneNumber'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            CheckOutTextFormField(
                                validator: (value) =>
                                    Validator.phoneValidate(value),
                                controller: phoneController,
                                size: size,
                                hintText: phoneNumber.toString(),
                                maxLines: 1),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              LanguageManager.translate('enterAddress'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.35,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          5, 5.5, 5, 0),
                                      filled: true,
                                      fillColor:
                                          AppColor.scaffoldBackgroundColor,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor
                                                  .disableIconColorDark),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor
                                                  .disableIconColorDark),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor.redColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor.redColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    menuMaxHeight: 200,
                                    value: selectedState,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a state';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      LanguageManager.translate('selectAState'),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedState = newValue;
                                      });
                                    },
                                    items: myanmarStates
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: size.width * 0.35,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    isDense: true,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          5, 5.5, 5, 0),
                                      filled: true,
                                      fillColor:
                                          AppColor.scaffoldBackgroundColor,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor
                                                  .disableIconColorDark),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor
                                                  .disableIconColorDark),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor.redColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColor.redColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    menuMaxHeight: 200,
                                    value: selectedCity,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a city';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      LanguageManager.translate('selectACity'),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    },
                                    items: myanmarCities
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            CheckOutTextFormField(
                                validator: (value) =>
                                    Validator.nameValidate(value),
                                controller: addressController,
                                size: size,
                                hintText: LanguageManager.translate(
                                    "building number, street name, district"),
                                maxLines: 3),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1,
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      activeColor: AppColor.mintGreen,
                                      value: isRememberAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          isRememberAddress = value!;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  LanguageManager.translate('rememberAddress'),
                                  style: const TextStyle(
                                    color: AppColor.swatch,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    const MySeparator(
                      color: AppColor.greenColor,
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: LanguageManager.translate('totalPrice'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            const TextSpan(
                              text: ' :',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ])),
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.greenColor),
                            child: FittedBox(
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: totalPrice.toString(),
                                  style: const TextStyle(
                                      color: AppColor.scaffoldBackgroundColor,
                                      fontSize: 20),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: LanguageManager.translate('mmk'),
                                  style: const TextStyle(
                                      color: AppColor.scaffoldBackgroundColor,
                                      fontSize: 17),
                                )
                              ])),
                            ),
                          )
                        ],
                      ),
                    ),
                    const MySeparator(
                      color: AppColor.greenColor,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      LanguageManager.translate('SelectPaymentMethod'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CheckOutBloc>().add(KpayEvent());
                            },
                            child: PaymentMethod(
                              size: size,
                              choosedPayment: choosedPayment,
                              photo: 'assets/images/kpay.png',
                              name: 'KBZPay',
                              choice: 'KBZPay',
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CheckOutBloc>().add(WavePayEvent());
                            },
                            child: PaymentMethod(
                              size: size,
                              choosedPayment: choosedPayment,
                              photo: 'assets/images/wavepay.png',
                              name: 'WavePay',
                              choice: 'WavePay',
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<CheckOutBloc>()
                                  .add(CashOnDeliveryEvent());
                            },
                            child: PaymentMethod(
                              size: size,
                              choosedPayment: choosedPayment,
                              name: 'Cash On Delivery',
                              choice: 'Cash On Delivery',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    BlocBuilder<CheckOutBloc, CheckOutState>(
                      builder: (context, state) {
                        if (state is CheckOutKpayState ||
                            state is CheckOutWavePayState) {
                          return SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: size.height * 0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColor.scaffoldBackgroundColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Scan Qr Code",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  BlocBuilder<CheckOutBloc, CheckOutState>(
                                    builder: (context, state) {
                                      if (state is CheckOutKpayState) {
                                        return qrCode(
                                            size,
                                            "assets/images/kpayQR.jpg",
                                            const Color.fromRGBO(
                                                1, 79, 157, 40),
                                            _image,
                                            AppColor.scaffoldBackgroundColor);
                                      }
                                      if (state is CheckOutWavePayState) {
                                        return qrCode(
                                            size,
                                            "assets/images/wavepayQR.jpg",
                                            const Color(0xffFFE63C),
                                            _image,
                                            AppColor.swatch);
                                      }

                                      return Container();
                                    },
                                  )
                                ],
                              ));
                        }

                        return Container();
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.greenColor),
                      child: TextButton(
                          onPressed: () {
                            if (choosedPayment == "Cash On Delivery") {
                              var model = PaymentModel(
                                  nameController.text,
                                  phoneController.text,
                                  selectedState.toString(),
                                  selectedCity.toString(),
                                  addressController.text,
                                  _image,
                                  isRememberAddress);
                              if (_checkOutKey.currentState?.validate() ==
                                  true) {
                                Dialogs.materialDialog(
                                    msg:
                                        'By clicking "Confirm", You agree that the data you provided are correct.',
                                    title: "Confimation",
                                    color: Colors.white,
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          context.back();
                                        },
                                        text: 'Cancel',
                                        iconData: Icons.cancel_outlined,
                                        textStyle:
                                            const TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                      IconsButton(
                                        onPressed: () {
                                          context
                                              .read<CheckOutBloc>()
                                              .add(CheckOutConfirmEvent(model));
                                        },
                                        text: 'Confirm',
                                        iconData: IconlyLight.tick_square,
                                        color: AppColor.greenColor,
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                    ]);
                              }
                            } else if (choosedPayment == "KBZPay" ||
                                choosedPayment == "WavePay") {
                              if (_image == null) {
                                Dialogs.materialDialog(
                                    msg:
                                        'Make sure you have uploaded the image of payment.',
                                    title: "Insufficient Data",
                                    color: AppColor.mildRed,
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          context.back();
                                        },
                                        text: 'Ok',
                                        color: AppColor.swatch,
                                        iconData: Icons.cancel_outlined,
                                        textStyle:
                                            const TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                    ]);
                              } else {
                                var model = PaymentModel(
                                    nameController.text,
                                    phoneController.text,
                                    selectedState.toString(),
                                    selectedCity.toString(),
                                    addressController.text,
                                    _image,
                                    isRememberAddress);
                                if (_checkOutKey.currentState?.validate() ==
                                    true) {
                                  Dialogs.materialDialog(
                                      msg:
                                          'By clicking "Confirm", You agree that the data you provided are correct.',
                                      title: "Confimation",
                                      color: Colors.white,
                                      context: context,
                                      actions: [
                                        IconsOutlineButton(
                                          onPressed: () {
                                            context.back();
                                          },
                                          text: 'Cancel',
                                          iconData: Icons.cancel_outlined,
                                          textStyle: const TextStyle(
                                              color: Colors.grey),
                                          iconColor: Colors.grey,
                                        ),
                                        IconsButton(
                                          onPressed: () {
                                            context.read<CheckOutBloc>().add(
                                                CheckOutConfirmEvent(model));
                                          },
                                          text: 'Confirm',
                                          iconData: IconlyLight.tick_square,
                                          color: AppColor.greenColor,
                                          textStyle: const TextStyle(
                                              color: Colors.white),
                                          iconColor: Colors.white,
                                        ),
                                      ]);
                                }
                              }
                            } else {
                              Dialogs.materialDialog(
                                  msg: 'You have not selected a Payment Method',
                                  title: "Insufficient Data",
                                  color: AppColor.mildRed,
                                  context: context,
                                  actions: [
                                    IconsOutlineButton(
                                      onPressed: () {
                                        context.back();
                                      },
                                      text: 'Ok',
                                      color: AppColor.swatch,
                                      iconData: Icons.cancel_outlined,
                                      textStyle:
                                          const TextStyle(color: Colors.grey),
                                      iconColor: Colors.grey,
                                    ),
                                  ]);
                            }
                          },
                          child: Text(
                            LanguageManager.translate("confirmOrder"),
                            style: const TextStyle(
                                color: AppColor.scaffoldBackgroundColor,
                                fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox qrCode(
      Size size, String qrCode, Color color, File? image, Color buttonColor) {
    return SizedBox(
      height: size.height * 0.3,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: AssetImage(qrCode),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColor.disableIconColorDark),
                    color: color),
                child: TextButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: FittedBox(
                      child: Text(
                        "Upload payment screenshot",
                        style: TextStyle(color: buttonColor),
                      ),
                    )),
              ),
              (image != null)
                  ? Expanded(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsetsDirectional.all(5),
                          child: Image.file(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ))
        ],
      ),
    );
  }
}
