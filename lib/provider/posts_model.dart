import 'package:flutter/material.dart';
import 'package:test_state_management/api.dart';
import 'package:test_state_management/post.dart';

class PostsModel with ChangeNotifier {
  List<Post> _posts = [];
  bool _loading = false;

  PostsModel() {
    fetchPosts();
  }

  bool isLoading() => _loading;

  List<Post> getPosts() => _posts;

  Future<void> fetchPosts() async {
    _loading = true;
    notifyListeners();
    _posts = await Api.getPost();
    _loading = false;
    notifyListeners();
  }
}
