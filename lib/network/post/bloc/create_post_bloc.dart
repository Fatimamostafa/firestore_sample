import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glint_test/network/post/moodel/user.dart';
import 'package:glint_test/network/utils/loading_bloc.dart';
import 'package:glint_test/utils/firebase.dart';

class CreatePostBloc {

  
  /// Uploads post to the post collection in Firestore
  uploadPost(String description) async {
    loadingBloc.start(LoadingType.createPost);

    DocumentSnapshot doc =
        await usersRef.doc(firebaseAuth.currentUser!.uid).get();

    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    var ref = postRef.doc();
    ref.set({
      'id': ref.id,
      'postId': ref.id,
      'username': user.username,
      'ownerId': firebaseAuth.currentUser!.uid,
      'description': description,
      'timestamp': Timestamp.now(),
    }).then((value) {
      loadingBloc.end(LoadingType.createPost);
    }).catchError((e) {
      print(e);
      loadingBloc.end(LoadingType.createPost);
    });
  }
}

final createPostBloc = CreatePostBloc();
