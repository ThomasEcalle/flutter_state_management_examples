import 'package:test_state_management/post.dart';

abstract class SelectedPostState {
  SelectedPostState([List props = const []]);
}

class PostsSelected extends SelectedPostState {
  final Post post;

  PostsSelected(this.post);

  @override
  String toString() => 'PostsSelected';
}

class InitialSelectedPostState extends SelectedPostState {
  @override
  String toString() => 'InitialSelectedPostState';
}
