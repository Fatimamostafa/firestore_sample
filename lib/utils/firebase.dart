import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;

// Collection refs
CollectionReference usersRef = fireStore.collection('users');
CollectionReference postRef = fireStore.collection('posts');
