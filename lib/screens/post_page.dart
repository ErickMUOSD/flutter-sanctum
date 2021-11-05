import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/models/post.dart';
import 'package:flutter_laravel_sanctum/services/dio.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Future<List<Post>> getPosts() async {
    Dio.Response res = await dio()
        .get('auth/posts', options: Dio.Options(headers: {'auth': true}));
    List posts = json.decode(res.toString());
    return posts.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getPosts(),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (contex, index) {
                  var item = snapshot.data![index];

                  return ListTile(
                    title: Text(item.title),
                  );
                },
              );
            } else if (snapshot.hasError) {
              log('error');
              log(snapshot.error.toString());
              return Text('Failed to load posts');
            }
            //log(snapshot.data.toString());

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
