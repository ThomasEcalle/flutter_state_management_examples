import 'package:equatable/equatable.dart';
import 'package:test_state_management/post.dart';

abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostsLoading extends PostState {
  @override
  String toString() => 'PostsLoading';
}

class PostsLoadingSuccess extends PostState {
  PostsLoadingSuccess({this.posts});

  final List<Post> posts;

  @override
  String toString() => 'PostsLoadingSuccess';
}

class PostsLoadingError extends PostState {
  @override
  String toString() => 'PostsLoadingError';
}

class PostsInitialState extends PostState {
  @override
  String toString() => 'PostsInitialState';
}
