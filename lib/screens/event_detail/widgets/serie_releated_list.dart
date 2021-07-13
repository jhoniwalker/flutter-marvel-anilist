import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_releated_list.dart';
import 'package:flutter/material.dart';

class SerieReleatedList extends StatelessWidget {
  const SerieReleatedList({Key key, this.eventId}) : super(key: key);

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<Serie>>(
      future: MarvelApiService().getEventSeries(eventId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageReleatedList(
              label: "Series",
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
