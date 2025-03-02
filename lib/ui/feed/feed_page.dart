import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firestore_sample/network/authentication/service/auth_service.dart';
import 'package:firestore_sample/network/post/moodel/post.dart';
import 'package:firestore_sample/ui/feed/widgets/fab_container.dart';
import 'package:firestore_sample/ui/feed/widgets/users_post.dart';
import 'package:firestore_sample/utils/firebase.dart';
import 'package:firestore_sample/utils/spacing.dart';
import 'package:firestore_sample/values/colors.dart';
import 'package:firestore_sample/widgets/loading_indicator.dart';
import 'package:firestore_sample/widgets/text.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed';

  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> queryStream =
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
          stream: queryStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return TextX(text: 'Something went wrong ${snapshot.error}');
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
