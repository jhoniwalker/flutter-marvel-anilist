import 'package:flutter/material.dart';
import './widgets/comic_releated_list.dart';
import './widgets/creator_releated_list.dart';
import './widgets/serie_releated_list.dart';
import './widgets/character_releated_list.dart';
import 'package:actividad_05/models/marvel_event.dart';

class EventReleatedContentImplementation extends StatelessWidget {
  const EventReleatedContentImplementation({Key key, this.event})
      : super(key: key);

  final MarvelEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CharacterReleatedList(eventId: event.id),
      SerieReleatedList(eventId: event.id),
      ComicReleatedList(eventId: event.id),
      CreatorReleatedList(eventId: event.id)
    ]);
  }
}
