import 'package:flutter/material.dart';
import './widgets/comic_releated_list.dart';
import './widgets/event_releated_list.dart';
import './widgets/serie_releated_list.dart';
import 'package:actividad_05/models/creator.dart';

class CreatorReleatedContentImplementation extends StatelessWidget {
  const CreatorReleatedContentImplementation({Key key, this.creator})
      : super(key: key);

  final Creator creator;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ComicReleatedList(creatorId: creator.id),
      EventReleatedList(creatorId: creator.id),
      SerieReleatedList(creatorId: creator.id)
    ]);
  }
}
