import 'package:equatable/equatable.dart';
import 'package:test_state_management/post.dart';

abstract class SelectedPostEvent extends Equatable {
  SelectedPostEvent([List props = const []]) : super(props);
}

class SelectPostEvent extends SelectedPostEvent {
  final Post post;

  SelectPostEvent(this.post);

  @override
  String toString() => 'SelectPostEvent';
}
