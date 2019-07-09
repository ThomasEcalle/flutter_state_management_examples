import 'package:bloc/bloc.dart';
import 'package:test_state_management/api.dart';
import 'package:test_state_management/bloc/bloc/posts/post_event.dart';
import 'package:test_state_management/bloc/bloc/posts/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostsInitialState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is RetrievePostEvent) {
      yield PostsLoading();
      try {
        final posts = await Api.getPost();
        yield PostsLoadingSuccess(posts: posts);
      } catch (error) {
        yield PostsLoadingError();
      }
    }
  }
}
