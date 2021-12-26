import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

enum LoadingType {
  login,
  signup,
  logout,
  createPost,
  deletePost,
  updatePost
}

/// A class that shows/hides loading indicators on Firestore requests/response
class LoadingBloc {
  final BehaviorSubject<List<LoadingType>> _subjectIsLoading =
      BehaviorSubject<List<LoadingType>>();

  BehaviorSubject<List<LoadingType>> get subjectIsLoading => _subjectIsLoading;

  List<LoadingType> list = [];

  start(LoadingType type) {
    list.add(type);
    _subjectIsLoading.sink.add(list);
  }

  end(LoadingType type) {
    if (list.contains(type)) {
      list.remove(type);
    }
    _subjectIsLoading.sink.add(list);
  }

  dispose() {
    _subjectIsLoading.close();
  }
}

final loadingBloc = LoadingBloc();

extension LoadingTypeExtension on AsyncSnapshot<List<LoadingType>> {
  bool isLoading(LoadingType type) {
    return hasData && data != null && data!.contains(type);
  }
}
