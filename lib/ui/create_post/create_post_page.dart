import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glint_test/network/post/moodel/post.dart';
import 'package:glint_test/network/post/service/posts_service.dart';
import 'package:glint_test/network/loader/loading_bloc.dart';
import 'package:glint_test/ui/create_post/widgets/post_input_field.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/widgets/loader_button.dart';
import 'package:glint_test/widgets/text.dart';

class CreatePostPage extends StatefulWidget {
  final PostModel? post;

  const CreatePostPage({Key? key, this.post}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final _postController = TextEditingController(
      text: widget.post != null ? widget.post!.description : '');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorsX.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: TextX(
              text: widget.post != null ? 'Update post' : 'Create Post',
              textAlign: TextAlign.center,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 24.0),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            const Spacing(size: 2),
            const TextX(
              text: 'Write your post',
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
            const Spacing(size: 2),
            PostInputField(
              onSubmitted: () {},
              hintText: 'Start typing..',
              length: 280,
              controller: _postController,
              line: 5,
            ),
            const Spacing(size: 4),
            StreamBuilder<List<LoadingType>>(
                stream: loadingBloc.subjectIsLoading,
                builder: (context, isLoading) {
                  return LoaderButton(
                      label: widget.post != null ? 'Update' : 'Post',
                      isLoading: isLoading.hasData &&
                          isLoading.data!.contains(LoadingType.createPost),
                      onPressed: () {
                        if(_postController.value.text.toString().isEmpty) {
                          return;
                        }
                        widget.post != null ? _updatePost() : _createPost();
                      });
                }),
          ],
        ),
      ),
    );;
  }

  void _createPost() async {

    final isPosted = await postsService.uploadPost(_postController.value.text);
    if (isPosted) {
      showSnackBar('Post submitted');
      Navigator.pop(context);
    } else {
      showSnackBar('Failed!', ColorsX.error);
    }
  }

  void _updatePost() async {
    final isUpdate = await postsService.updatePost(
        widget.post!.id!, _postController.value.text);
    if (isUpdate) {
      showSnackBar('Post updated');
      Navigator.pop(context);
    } else {
      showSnackBar('Failed!', ColorsX.error);
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message,
      [Color? color]) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.removeCurrentSnackBar();
    return scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color ?? ColorsX.primaryPurple,
    ));
  }
}
