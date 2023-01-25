import 'package:apitest/models/post.dart';
import 'package:apitest/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '30 Minuten lol'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post>? posts;
  var dataLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    posts = await getPosts();
    if (posts != null) {
      setState(() {
        dataLoaded = true;
      });
    }
  }

  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse("https://hurseda.net/v1/?content=news&limit=20");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: dataLoaded
          ? ListView.builder(
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(posts![index].title),
                      subtitle: Text(posts![index].intro),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreeen(
                            posts![index],
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const  BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        posts![index].image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: posts!.length,
            )
          : const Center(
              child: Text("Loading"),
            ),
    );
  }
}
