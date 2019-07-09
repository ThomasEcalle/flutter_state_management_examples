import 'package:flutter/material.dart';
import 'package:test_state_management/api.dart';
import 'package:test_state_management/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Post _selectedPost;

  _selectPost(Post post) {
    setState(() {
      _selectedPost = post;
    });
    // May have API calls logic here -> bad practice
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Posts(
                onSelected: (post) => _selectPost(post),
              ),
              flex: 2,
            ),
            Expanded(
              child: SelectedPost(
                post: _selectedPost,
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class SelectedPost extends StatelessWidget {
  final Post post;

  const SelectedPost({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return Center(
        child: Text("Aucun post sélectionné"),
      );
    } else {
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
  final Function(Post) onSelected;

  const Posts({Key key, @required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.getPost(),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].body),
                onTap: () => this.onSelected != null
                    ? this.onSelected(posts[index])
                    : print("Aucune callback"),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
