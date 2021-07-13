import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/screens/creator_detail/creator_releated_content_implementation.dart';
import 'package:flutter/material.dart';

class CreatorReleatedContent extends StatelessWidget {
  const CreatorReleatedContent({Key key, @required this.creator})
      : super(key: key);

  final Creator creator;

  @override
  Widget build(BuildContext context) {
    return CreatorReleatedContentImplementation(creator: creator);
  }
}
