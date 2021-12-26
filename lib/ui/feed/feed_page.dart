import 'package:flutter/material.dart';
import 'package:glint_test/network/authentication/auth_bloc.dart';

import 'package:glint_test/ui/feed/widgets/fab_container.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/text.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed';

  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsX.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              color: ColorsX.primaryPurple,
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                authBloc.logout();
              }),
        ],
        title: const TextX(
            text: 'Feed',
            textAlign: TextAlign.center,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.0),
      ),
      floatingActionButton: Container(
        color: Colors.transparent,
        height: 45.0,
        width: 45.0,
        child: const FabContainer(
          icon: Icons.add,
          mini: true,
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
