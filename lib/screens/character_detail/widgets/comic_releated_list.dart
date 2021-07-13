import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_releated_list.dart';
import 'package:flutter/material.dart';

class ComicReleatedList extends StatelessWidget {
  const ComicReleatedList({Key key, this.characterId}) : super(key: key);

  final int characterId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<Comic>>(
      future: MarvelApiService().getCharacterComics(characterId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageReleatedList(
              label: "Comics",
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
