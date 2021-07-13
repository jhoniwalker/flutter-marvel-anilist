import 'package:flutter/material.dart';
import './widgets/character_releated_list.dart';
import './widgets/event_releated_list.dart';
import './widgets/creator_releated_list.dart';
import 'package:actividad_05/models/comic.dart';

class ComicReleatedContentImplementation extends StatelessWidget {
  const ComicReleatedContentImplementation({Key key, this.comic})
      : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CharacterReleatedList(comicId: comic.id),
      EventReleatedList(comicId: comic.id),
      CreatorReleatedList(comicId: comic.id)
    ]);
  }
}
