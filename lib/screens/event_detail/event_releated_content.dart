import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/screens/event_detail/event_releated_content_implementation.dart';
import 'package:flutter/material.dart';

class EventReleatedContent extends StatelessWidget {
  const EventReleatedContent({Key key, @required this.event}) : super(key: key);

  final MarvelEvent event;

  @override
  Widget build(BuildContext context) {
    return EventReleatedContentImplementation(event: event);
  }
}
