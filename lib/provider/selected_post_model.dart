import 'package:flutter/material.dart';
import 'package:test_state_management/post.dart';

class SelectedPostModel with ChangeNotifier {
  Post _selectedPost;

  Post getSelectedPost() => _selectedPost;

  selectPost(Post post) {
    _selectedPost = post;
    notifyListeners();
  }
}
