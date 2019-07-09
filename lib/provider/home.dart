import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_state_management/provider/model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<PostsModel>(
          builder: (_) => PostsModel(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Posts(),
                flex: 2,
              ),
              Expanded(
                child: SelectedPost(),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PostsModel>(context);
    if (model.getSelectedPost() == null) {
      return Center(
        child: Text("Aucun post sélectionné"),
      );
    } else {
      final post = model.getSelectedPost();
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
    }
  }
}

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PostsModel>(context);
    if (model.isLoading()) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final posts = model.getPosts();
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
            onTap: () => model.selectPost(posts[index]),
          );
        },
      );
    }
  }
}
