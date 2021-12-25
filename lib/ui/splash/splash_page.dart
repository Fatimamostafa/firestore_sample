import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glint_test/main.dart';
import 'package:glint_test/ui/signup/signup_page.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kUserSession = 'usersSession';

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
      //_checkUserStatus();
      Navigator.pushNamed(context, SignupPage.routeName);
    });
  }

  // void _checkUserStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   final userSession =
  //       prefs.getString(_kUserSession) ?? '';
  //
  //   final json = jsonDecode(userSession) as Map<String, dynamic>;
  //
  // }

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
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: applySpacing(15)),
              alignment: Alignment.bottomCenter,
              width: applySpacing(8),
              height: applySpacing(0.5),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.deepPurple,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
            )
          ],
        ));
  }
}
