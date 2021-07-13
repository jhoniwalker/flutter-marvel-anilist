import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/screens/event_detail/event_releated_content.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EventDetailScreenImplementation extends StatefulWidget {
  const EventDetailScreenImplementation({Key key, this.event})
      : super(key: key);

  final MarvelEvent event;

  @override
  _EventDetailScreenImplementationState createState() =>
      _EventDetailScreenImplementationState();
}

class _EventDetailScreenImplementationState
    extends State<EventDetailScreenImplementation> {
  List<dynamic> favouritedEvents = [];

  toggleFavourite(MarvelEvent event) => () async {
        setState(() {
          if (favouritedEvents.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == event.id,
                  orElse: () => null) !=
              null) {
            favouritedEvents.removeWhere((item) => item['id'] == event.id);
          } else {
            favouritedEvents.add({
              'id': event.id,
              'title': event.title,
              'description': event.description,
              'thumbnail': event.thumbnail,
              'urls': event.urls
            });
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteEvents = prefs.getString('favouriteEvents') ?? '[]';

          print('From sharedProps $favouriteEvents');

          List<dynamic> favouriteEventList = json.decode(favouriteEvents);

          if (favouriteEventList.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == event.id,
                  orElse: () => null) !=
              null) {
            favouriteEventList.removeWhere((item) => item['id'] == event.id);
          } else {
            favouriteEventList.add({
              'id': event.id,
              'title': event.title,
              'description': event.description,
              'thumbnail': event.thumbnail,
              'urls': event.urls
            });
          }

          await prefs.setString(
              'favouriteEvents', json.encode(favouriteEventList));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteEvents() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteEvents = prefs.getString('favouriteEvents') ?? '[]';
      List<dynamic> eventFavourites = json.decode(favouriteEvents);

      print('From INIT STATE $eventFavourites');
      setState(() {
        favouritedEvents = eventFavourites;
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
    final event = ModalRoute.of(context).settings.arguments as MarvelEvent;

    final star = Container(
      margin: EdgeInsets.only(top: 5.0, right: 3.0, bottom: 5.0),
      child: Icon(Icons.star, color: Color(0xFFf2C611), size: 40.0),
    );
    final starHalf = Container(
      margin: EdgeInsets.only(top: 5.0, right: 3.0, bottom: 5.0),
      child: Icon(Icons.star_half, color: Color(0xFFf2C611), size: 40.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          DetailHeroWithBackBtn(thumbnail: event.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: toggleFavourite(event != null ? event : null),
                icon: (favouritedEvents.firstWhere(
                            (itemToCheck) => itemToCheck['id'] == event.id,
                            orElse: () => null) !=
                        null)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline),
                iconSize: 40.0,
                color: Colors.black,
              ),
              IconButton(
                onPressed: () => print('Share'),
                icon: Icon(Icons.share),
                iconSize: 35.0,
                color: Colors.black,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                event.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [star, star, star, star, starHalf],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 120.0,
                child: SingleChildScrollView(
                  child: Text(
                    event.description,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'RELATED CONTENT',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          EventReleatedContent(
            event: event,
          ),
          Attribution(),
        ],
      ),
    );
  }
}
