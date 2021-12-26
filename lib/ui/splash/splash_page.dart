import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/main.dart';
import 'package:glint_test/ui/login/login_page.dart';
import 'package:glint_test/ui/signup/signup_page.dart';
import 'package:glint_test/utils/locator.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      _checkUserStatus();
    });
  }

  void _checkUserStatus() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        locator<NavigationService>().navigateTo(
          SignupPage.routeName,
          replace: true,
        );
      } else {
        locator<NavigationService>().navigateTo(
          LoginPage.routeName,
          replace: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Center(
              child: Text(
                'Glints Test',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: applySpacing(15),
              ),
              alignment: Alignment.bottomCenter,
              width: applySpacing(8),
              height: applySpacing(0.5),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
            )
          ],
        ));
  }
}
