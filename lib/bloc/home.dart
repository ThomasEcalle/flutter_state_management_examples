import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_state_management/bloc/bloc/posts/post_bloc.dart';
import 'package:test_state_management/bloc/bloc/posts/post_event.dart';
import 'package:test_state_management/bloc/bloc/posts/post_state.dart';
import 'package:test_state_management/bloc/bloc/selected_post/selected_post_event.dart';
import 'package:test_state_management/bloc/bloc/selected_post/selected_post_state.dart';

import 'bloc/selected_post/selected_post_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostBloc postBloc = PostBloc();
  final SelectedPostBloc selectedPostBloc = SelectedPostBloc();

  @override
  void initState() {
    super.initState();
    postBloc.dispatch(RetrievePostEvent());
  }

  @override
  void dispose() {
    super.dispose();
    postBloc.dispose();
    selectedPostBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProviderTree(
            blocProviders: [
              BlocProvider<PostBloc>(
                bloc: postBloc,
              ),
              BlocProvider<SelectedPostBloc>(
                bloc: selectedPostBloc,
              ),
            ],
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Body(),
                  flex: 2,
                ),
                Expanded(
                  child: SelectedPost(),
                  flex: 1,
                ),
              ],
            )),
      ),
    );
  }
}

class SelectedPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<SelectedPostBloc>(context),
        builder: (BuildContext context, SelectedPostState state) {
          if (state is PostsSelected) {
            final post = state.post;
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Titre du post sélectionné !",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      post.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Aucun post sélectionné"),
            );
          }
        });
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PostBloc>(context),
      builder: (BuildContext context, PostState state) {
        if (state is PostsInitialState) {
          return Container();
        } else if (state is PostsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostsLoadingError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostsLoadingSuccess) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].body),
                onTap: () => BlocProvider.of<SelectedPostBloc>(context)
                    .dispatch(SelectPostEvent(posts[index])),
              );
            },
          );
        }
      },
    );
  }
}
