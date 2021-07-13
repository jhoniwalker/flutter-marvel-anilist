import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/serie_detail/serie_releated_content_implementation.dart';
import 'package:flutter/material.dart';

class SerieReleatedContent extends StatelessWidget {
  const SerieReleatedContent({Key key, @required this.serie}) : super(key: key);

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return SerieReleatedContentImplementation(serie: serie);
  }
}
