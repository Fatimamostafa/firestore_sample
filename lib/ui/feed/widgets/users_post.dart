import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/network/post/moodel/post.dart';
import 'package:glint_test/network/authentication/model/user.dart';
import 'package:glint_test/utils/firebase.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/card.dart';
import 'package:glint_test/widgets/text.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserPost extends StatelessWidget {
  final PostModel post;

  UserPost({Key? key, required this.post}) : super(key: key);

  final DateTime timestamp = DateTime.now();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUser(context),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(
                    text: post.description,
                    color: Theme.of(context).textTheme.caption!.color,
                    fontSize: 16.0,
                  ),
                  const Spacing(
                    size: 1,
                  ),
                  TextX(
                      text: timeago.format(post.timestamp!.toDate()),
                      fontSize: 10.0)
                  // SizedBox(height: 5.0),
                ],
              ),
            )
          ],
        ));
  }

  buildUser(BuildContext context) {
    bool isMe = currentUserId() == post.ownerId;
    return StreamBuilder(
      stream: usersRef.doc(post.ownerId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data as DocumentSnapshot<Object?>;
          UserModel user =
              UserModel.fromJson(snap.data() as Map<String, dynamic>);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: applySpacing(1)),
              height: applySpacing(5),
              decoration: BoxDecoration(
                color: ColorsX.primaryPurple.withAlpha(60),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextX(
                    text: user.username,
                    fontWeight: FontWeight.bold,
                    color: ColorsX.darkBlueGrey,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Visibility(
                      visible: isMe,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_forever),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
