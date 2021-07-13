import 'package:flutter/material.dart';
import './widgets/serie_releated_list.dart';
import './widgets/comic_releated_list.dart';
import './widgets/event_releated_list.dart';

import '../../models/character.dart';

class CharacterReleatedContentImplementation extends StatelessWidget {
  const CharacterReleatedContentImplementation({Key key, this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SerieReleatedList(characterId: character.id),
      ComicReleatedList(characterId: character.id),
      EventReleatedList(characterId: character.id)
    ]);
  }
}
