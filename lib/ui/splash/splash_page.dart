import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firestore_sample/ui/feed/feed_page.dart';
import 'package:firestore_sample/ui/signup/signup_page.dart';
import 'package:firestore_sample/utils/locator.dart';
import 'package:firestore_sample/utils/navigation_service.dart';
import 'package:firestore_sample/utils/spacing.dart';
import 'package:firestore_sample/values/colors.dart';
import 'package:firestore_sample/widgets/text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription? _streamLogin;

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
    _streamLogin =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        locator<NavigationService>().navigateTo(
          SignupPage.routeName,
          replace: true,
        );
      } else {
        locator<NavigationService>().navigateTo(
          FeedPage.routeName,
          replace: true,
        );
      }
    });
  }

  @override
  void dispose() {
    _streamLogin!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextX(
                    text: 'Flutter Test',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  Spacing(
                    size: 1,
                  ),
                  TextX(
                    text: 'Fatima Mostafa',
                    color: ColorsX.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ],
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  ),
                ))
          ],
        ));
  }
}
