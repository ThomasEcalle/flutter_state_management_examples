import 'package:equatable/equatable.dart';
import 'package:test_state_management/post.dart';

abstract class PostEvent extends Equatable {
  PostEvent([List props = const []]) : super(props);
}

class RetrievePostEvent extends PostEvent {
  @override
  String toString() => 'RetrievePostEvent';
}
