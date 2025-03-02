import 'package:firestore_sample/ui/feed/feed_page.dart';
import 'package:firestore_sample/ui/login/login_page.dart';
import 'package:firestore_sample/ui/signup/signup_page.dart';
import 'package:firestore_sample/ui/splash/splash_page.dart';
import 'package:firestore_sample/utils/locator.dart' show locator, setupLocator;
import 'package:firestore_sample/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  await _portrait();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        FeedPage.routeName: (ctx) => const FeedPage(),
      },
      home: const SplashPage(),
    );
  }
}

/// Locks app in portrait orientation
Future<void> _portrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
