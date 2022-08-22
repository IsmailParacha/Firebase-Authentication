import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/API/Controller/remoteServices.dart';
import 'package:flutter_application_1/API/Model/Post.dart';

class api extends StatefulWidget {
  const api({Key? key}) : super(key: key);

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await remoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API using"),
          centerTitle: true,
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: ((context, index) {
                return Container(
                    child: Column(
                  children: [
                    Text(
                      posts![index].title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(posts![index].body ?? ''),
                  ],
                ));
              })),
          replacement: const Center(child: CircularProgressIndicator()),
        ));
  }
}
