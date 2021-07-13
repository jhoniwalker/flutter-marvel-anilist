import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/screens/comic_detail/comic_releated_content_implementation.dart';
import 'package:flutter/material.dart';

class ComicReleatedContent extends StatelessWidget {
  const ComicReleatedContent({Key key, @required this.comic}) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return ComicReleatedContentImplementation(comic: comic);
  }
}
