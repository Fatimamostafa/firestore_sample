import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glint_test/network/loader/loading_bloc.dart';
import 'package:glint_test/ui/signup/signup_page.dart';
import 'package:glint_test/utils/firebase.dart';
import 'package:glint_test/utils/locator.dart';
import 'package:glint_test/utils/navigation_service.dart';

class AuthService {
  /// Registers a new user in Firestore database
  Future<dynamic> register(String email, String pass, String name) async {
    loadingBloc.start(LoadingType.signup);

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (userCredential.user?.uid == currentUser?.uid) {
        User? user = userCredential.user;

        await saveUserToFirestore(
          name: name,
          user: user!,
          email: email,
        );

        loadingBloc.end(LoadingType.signup);

        return user;
      }
    } on FirebaseAuthException catch (e) {
      loadingBloc.end(LoadingType.signup);
      return e.message;
    }
  }

  /// This will save the details inputted by the user to Firestore.
  saveUserToFirestore({
    required String name,
    required User user,
    required String email,
  }) async {
    await usersRef.doc(user.uid).set({
      'username': name,
      'email': email,
      'time': Timestamp.now(),
      'id': user.uid,
    });
  }

  /// Login function of a user with valid [email] and [pass]
  Future<dynamic> login(
    String email,
    String pass,
  ) async {
    try {
      loadingBloc.start(LoadingType.login);
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      loadingBloc.end(LoadingType.login);
      return user.user;
    } on FirebaseAuthException catch (e) {
      loadingBloc.end(LoadingType.login);
      return e.message;
    }
  }

  /// Logout from app feed page and navigate to [SignupPage]
  logout() {
    loadingBloc.start(LoadingType.logout);
    FirebaseAuth.instance.signOut().then((value) {
      loadingBloc.end(LoadingType.logout);
      locator<NavigationService>().navigateToRemoveUntil(SignupPage.routeName);
    }).catchError((e) {
      loadingBloc.end(LoadingType.logout);
    });
  }
}

final authService = AuthService();
