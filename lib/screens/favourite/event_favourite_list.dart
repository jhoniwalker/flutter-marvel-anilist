import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';

class EventFavouriteList extends StatefulWidget {
  const EventFavouriteList({Key key}) : super(key: key);

  @override
  _EventFavouriteList createState() => _EventFavouriteList();
}

class _EventFavouriteList extends State<EventFavouriteList> {
  List<dynamic> favouritedEvents = [];

  getFavouriteEvents() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteEvents = prefs.getString('favouriteEvents') ?? '[]';
      List<dynamic> serieFavourites = json.decode(favouriteEvents);
      setState(() {
        favouritedEvents = serieFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    List<MarvelEvent> comics =
        favouritedEvents.map((item) => MarvelEvent.fromJson(item)).toList();

    List<Thumbnail> thumbs = favouritedEvents
        .map((item) => Thumbnail.fromJson(item['thumbnail']))
        .toList();

    print(comics);

    return LabeledImageList(
        onTap: (index) => () => {
              Navigator.pushNamed(context, ROUTE_NAMES['EVENT_DETAIL'],
                      arguments: comics[index])
                  .then((_) => setState(() {
                        getFavouriteEvents();
                      }))
            },
        label: "Favs Events",
        thumbs: thumbs);
  }
}
