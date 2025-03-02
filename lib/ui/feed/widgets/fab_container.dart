import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firestore_sample/ui/create_post/create_post_page.dart';

class FabContainer extends StatelessWidget {
  final Widget? page;
  final IconData icon;
  final bool mini;

  const FabContainer(
      {super.key, this.page, required this.icon, this.mini = false});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return page!;
      },
      closedElevation: 4.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => const CreatePostPage(),
              ),
            );
          },
          mini: mini,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
