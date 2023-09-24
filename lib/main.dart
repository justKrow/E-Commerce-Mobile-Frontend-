import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:###/config/routes/routes.dart';
import 'package:###/local_storage/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await SharedPref.getStringValue(key: 'accessToken');
  bool isLoggedIn = token != null && token.isNotEmpty;

  runApp(
    MaterialApp(
      title: 'Myait Zimon Yin',
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? Routes.homeScreen : Routes.auth,
      onGenerateRoute: Routes.routeGenerator,
    ),
  );
}
