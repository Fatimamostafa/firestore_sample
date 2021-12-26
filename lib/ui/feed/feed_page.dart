import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/network/authentication/service/auth_service.dart';
import 'package:glint_test/network/post/moodel/post.dart';
import 'package:glint_test/ui/feed/widgets/fab_container.dart';
import 'package:glint_test/ui/feed/widgets/users_post.dart';
import 'package:glint_test/utils/firebase.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/loading_indicator.dart';
import 'package:glint_test/widgets/text.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed';

  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _queryStream =
        postRef.orderBy('timestamp', descending: true).snapshots();

    return Scaffold(
        backgroundColor: ColorsX.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: null,
          actions: <Widget>[
            IconButton(
                color: ColorsX.primaryPurple,
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  authService.logout();
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
          height: applySpacing(6),
          width: applySpacing(6),
          child: const FabContainer(
            icon: Icons.add,
            mini: true,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _queryStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const TextX(text: 'Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                final data = document.data()! as Map<String, dynamic>;
                PostModel posts = PostModel.fromJson(data);

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: UserPost(post: posts),
                );
              }).toList(),
            );
          },
        ));
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
