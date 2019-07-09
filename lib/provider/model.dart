import 'package:flutter/material.dart';
import 'package:test_state_management/api.dart';
import 'package:test_state_management/post.dart';

class PostsModel with ChangeNotifier {
  List<Post> _posts = [];
  Post _selectedPost;
  bool _loading = false;

  PostsModel() {
    fetchPosts();
  }

  bool isLoading() => _loading;

  List<Post> getPosts() => _posts;

  Post getSelectedPost() => _selectedPost;

  selectPost(Post post) {
    _selectedPost = post;
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _loading = true;
    notifyListeners();
    _posts = await Api.getPost();
    _loading = false;
    notifyListeners();
  }
}
