import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glint_test/ui/login/login_page.dart';
import 'package:glint_test/ui/signup/signup_page.dart';
import 'package:glint_test/ui/splash/splash_page.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupLocator();

  await _portrait();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Glints-Fatima',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      routes: <String, WidgetBuilder>{
        LoginPage.routeName: (ctx) => const LoginPage(),
        SignupPage.routeName: (ctx) => const SignupPage(),
      },
      home: const SplashPage(),
    );
  }
}

/// Locks app in portrait orientation
Future<void> _portrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

/// Setup singleton for navigation router service
Future<void> _setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}
