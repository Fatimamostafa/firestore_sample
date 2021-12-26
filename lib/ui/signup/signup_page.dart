import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/network/authentication/service/auth_service.dart';
import 'package:glint_test/network/loader/loading_bloc.dart';
import 'package:glint_test/ui/feed/feed_page.dart';
import 'package:glint_test/ui/login/login_page.dart';
import 'package:glint_test/utils/extension.dart';
import 'package:glint_test/utils/locator.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/loader_button.dart';
import 'package:glint_test/widgets/text.dart';
import 'package:glint_test/widgets/text_input_form.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController(text: '');
  final _emailTextController = TextEditingController(text: '');
  final _nameTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsX.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextX(
            text: 'Sign Up',
            textAlign: TextAlign.center,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.0),
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
                          controller: _nameTextController,
                          errorText: true,
                          title: 'Name',
                          hintText: 'Enter your full name',
                          keyboardType: TextInputType.name,
                          action: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Please insert your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Spacing(size: 2),
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
                          label: 'Create Account',
                          isLoading: isLoading.hasData &&
                              isLoading.data!.contains(LoadingType.signup),
                          onPressed: _createAccount);
                    }),
                const Spacing(size: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextX(
                        text: 'Already have an account? ',
                        color: ColorsX.blueGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                    const Spacing(
                      size: 0.4,
                      direction: Axis.horizontal,
                    ),
                    InkWell(
                      onTap: () {
                        locator<NavigationService>()
                            .navigateTo(LoginPage.routeName);
                      },
                      child: const TextX(
                          text: 'Login Now',
                          color: ColorsX.watermelon,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _createAccount() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final session = await authService.register(
      _emailTextController.value.text,
      _passwordTextController.value.text,
      _nameTextController.value.text,
    );

    if (session is User) {
      locator<NavigationService>()
          .navigateTo(FeedPage.routeName, replace: true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(session)));
    }
  }
}
