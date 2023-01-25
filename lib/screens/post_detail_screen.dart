import 'dart:math';
import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/post.dart';

class PostDetailScreeen extends StatelessWidget {
  final Post _post;
  var editedArticle = "";

  PostDetailScreeen(this._post);

  filterArticle() {
    final document = parse(_post.article);
     editedArticle = parse(document.body!.text).documentElement!.text;
  }

  @override
  Widget build(BuildContext context) {
    filterArticle();

    return Scaffold(
      appBar: AppBar(
        title: Text(_post.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                _post.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(editedArticle),
              const SizedBox(
                height: 20,
              ),
              Text(_post.addDate)
            ],
          ),
        ),
      ),
    );
  }
}
