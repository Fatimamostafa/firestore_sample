import 'package:flutter/material.dart';
import 'package:glint_test/network/authentication/auth_bloc.dart';
import 'package:glint_test/network/utils/loading_bloc.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/widgets/loader_button.dart';
import 'package:glint_test/widgets/text.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed';

  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextX(
            text: 'Feed',
            textAlign: TextAlign.center,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.0),
      ),
      body: Column(

        children: [
          Center(
            child: StreamBuilder<List<LoadingType>>(
                stream: loadingBloc.subjectIsLoading,
                builder: (context, isLoading) {
                  return LoaderButton(
                      label: 'Logout',
                      width: applySpacing(10),
                      isLoading: isLoading.hasData &&
                          isLoading.data!.contains(LoadingType.logout),
                      onPressed: () {
                        authBloc.logout();
                      });
                }),
          ),
        ],
      ),
    );
  }
}
