import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_releated_list.dart';
import 'package:flutter/material.dart';

class CharacterReleatedList extends StatelessWidget {
  const CharacterReleatedList({Key key, this.comicId}) : super(key: key);

  final int comicId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<Character>>(
      future: MarvelApiService().getComicCharactes(comicId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageReleatedList(
              label: "Characters",
              thumbs: snapshot.data.data.results
                  .map<Thumbnail>((item) => item.thumbnail)
                  .toList());
        } else if (snapshot.hasError) {
          return Text('ERROR');
        } else {
          return Text('Cargando...');
        }
      },
    );
  }
}
