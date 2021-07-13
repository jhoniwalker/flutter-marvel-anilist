import 'package:flutter/material.dart';
import 'widgets/comic_releated_list.dart';
import 'widgets/creator_releated_list.dart';
import 'widgets/event_releated_list.dart';
import 'widgets/character_releated_list.dart';
import 'package:actividad_05/models/serie.dart';

class SerieReleatedContentImplementation extends StatelessWidget {
  const SerieReleatedContentImplementation({Key key, this.serie})
      : super(key: key);

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CharacterReleatedList(serieId: serie.id),
      ComicReleatedList(serieId: serie.id),
      EventReleatedList(serieId: serie.id),
      CreatorReleatedList(serieId: serie.id)
    ]);
  }
}
