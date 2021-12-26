import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/network/authentication/service/auth_service.dart';
import 'package:glint_test/network/loader/loading_bloc.dart';
import 'package:glint_test/ui/feed/feed_page.dart';
import 'package:glint_test/utils/extension.dart';
import 'package:glint_test/utils/locator.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/loader_button.dart';
import 'package:glint_test/widgets/text_input_form.dart';

import '../../utils/spacing.dart';
import '../../widgets/text.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController(text: '');
  final _emailTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsX.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextX(
            text: 'Login',
            textAlign: TextAlign.center,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: applySpacing(3)),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Spacing(size: 3),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInputForm(
                          controller: _emailTextController,
                          errorText: true,
                          title: 'Email Address',
                          hintText: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          validator: (v) {
                            if (v == null || !v.isValidEmail) {
                              return 'Please insert valid email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Spacing(size: 2),
                        TextInputForm(
                          controller: _passwordTextController,
                          title: 'Password',
                          errorText: true,
                          hintText: 'Enter password',
                          keyboardType: TextInputType.visiblePassword,
                          action: TextInputAction.done,
                          validator: (v) {
                            if (v!.length < 6) {
                              return 'Password must be at least 6 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    )),
                const Spacing(size: 2),
                StreamBuilder<List<LoadingType>>(
                    stream: loadingBloc.subjectIsLoading,
                    builder: (context, isLoading) {
                      return LoaderButton(
                          label: 'Login',
                          isLoading: isLoading.hasData &&
                              isLoading.data!.contains(LoadingType.login),
                          onPressed: _login);
                    }),
                const Spacing(size: 7),
              ],
            ),
          )),
    );
  }

  void _login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final session = await authService.login(
      _emailTextController.value.text,
      _passwordTextController.value.text,
    );

    if (session is User) {
      locator<NavigationService>().navigateToRemoveUntil(FeedPage.routeName);
    } else if (session is String) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(session)));
    }
  }
}
