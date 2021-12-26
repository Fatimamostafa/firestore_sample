import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glint_test/network/authentication/model/user.dart';
import 'package:glint_test/network/utils/loading_bloc.dart';
import 'package:glint_test/utils/firebase.dart';

class CreatePostService {
  /// Uploads post to the post collection in Firestore
  Future<bool> uploadPost(String description) async {
    loadingBloc.start(LoadingType.createPost);

    DocumentSnapshot doc =
        await usersRef.doc(firebaseAuth.currentUser!.uid).get();
    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    var ref = postRef.doc();
    try {
      ref.set({
        'id': ref.id,
        'postId': ref.id,
        'username': user.username,
        'ownerId': firebaseAuth.currentUser!.uid,
        'description': description,
        'timestamp': Timestamp.now(),
      });
      loadingBloc.end(LoadingType.createPost);
      return true;
    } catch (e) {
      loadingBloc.end(LoadingType.createPost);
      return false;
    }
  }
}

final createPostService = CreatePostService();
