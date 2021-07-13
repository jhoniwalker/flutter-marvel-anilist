import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_releated_list.dart';
import 'package:flutter/material.dart';

class CreatorReleatedList extends StatelessWidget {
  const CreatorReleatedList({Key key, this.serieId}) : super(key: key);

  final int serieId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<Creator>>(
      future: MarvelApiService().getSerieCreators(serieId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageReleatedList(
              label: "Creators",
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
