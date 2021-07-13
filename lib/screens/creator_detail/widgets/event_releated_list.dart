import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_releated_list.dart';
import 'package:flutter/material.dart';

class EventReleatedList extends StatelessWidget {
  const EventReleatedList({Key key, this.creatorId}) : super(key: key);

  final int creatorId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<MarvelEvent>>(
      future: MarvelApiService().getCreatorEvents(creatorId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageReleatedList(
              label: "Events",
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
