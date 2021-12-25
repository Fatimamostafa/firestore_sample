import 'package:flutter/material.dart';
import 'package:glint_test/main.dart';
import 'package:glint_test/network/blocs/loading.dart';
import 'package:glint_test/ui/login/login_page.dart';
import 'package:glint_test/utils/extension.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/loader_button.dart';
import 'package:glint_test/widgets/text.dart';
import 'package:glint_test/widgets/text_input_form.dart';

class SignupPage extends StatelessWidget {
  static const routeName = '/signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  const TextX(
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
                    key: _form,
                    child: Column(
                      children: [
                        TextInputForm(
                          errorText: true,
                          title: 'Email Address',
                          hintText: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          onSaved: (value) {},
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
                          title: 'Password',
                          hintText: 'Enter password',
                          keyboardType: TextInputType.visiblePassword,
                          action: TextInputAction.done,
                          onSaved: (value) {},
                          validator: (v) {
                            if (v!.length >= 6) {
                              return null;
                            } else {
                              return 'Enter password';
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
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _form.currentState!.save();
                            //authBloc.register();
                          }
                        },
                      );
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
}
