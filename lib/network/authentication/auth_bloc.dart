import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glint_test/network/utils/loading_bloc.dart';
import 'package:glint_test/ui/signup/signup_page.dart';
import 'package:glint_test/utils/firebase.dart';
import 'package:glint_test/utils/locator.dart';
import 'package:glint_test/utils/navigation_service.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc {
  final BehaviorSubject<User?> _subjectUser = BehaviorSubject<User?>();

  BehaviorSubject<User?> get subjectUser => _subjectUser;

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
        _subjectUser.sink.add(user);

        return user;
      }
    } on FirebaseAuthException catch (e) {
      loadingBloc.end(LoadingType.signup);
      return e.message;
    }
  }

  /// This will save the details inputted by the user to firestore.
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

  Future<dynamic> login(
    String email,
    String pass,
  ) async {
    try {
      loadingBloc.start(LoadingType.login);
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      loadingBloc.end(LoadingType.login);
      User? user = userCredential.user;
      if (user != null) {
        getProfile();
      }
      _subjectUser.sink.add(user);
    } on FirebaseAuthException catch (e) {
      loadingBloc.end(LoadingType.login);
      return e.message;
    }
  }

  dispose() {
    _subjectUser.close();
  }

  getProfile() {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isEmpty) return;
  }

  isLoggedIn() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
    } else {}
  }

  logout() {
    loadingBloc.start(LoadingType.logout);
    FirebaseAuth.instance.signOut().then((value) {
      loadingBloc.end(LoadingType.logout);
      locator<NavigationService>().navigateToLogout(SignupPage.routeName);
      _subjectUser.sink.add(null);
    }).catchError((e) {
      loadingBloc.end(LoadingType.logout);
    });
  }

  User? getMe() {
    return FirebaseAuth.instance.currentUser;
  }
}

final authBloc = AuthBloc();
