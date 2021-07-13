import 'package:flutter/material.dart';
import 'package:actividad_05/screens/favourite/character_favourite_list.dart';
import 'package:actividad_05/screens/favourite/serie_favourite_list.dart';
import 'package:actividad_05/screens/favourite/comic_favourite_list.dart';
import 'package:actividad_05/screens/favourite/event_favourite_list.dart';
import 'package:actividad_05/screens/favourite/anime_favourite_list.dart';
import 'package:actividad_05/screens/favourite/creator_favourite_list.dart';

class FavsTabScreen extends StatelessWidget {
  const FavsTabScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        child: Text(
          'Comics',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
      ),
      CharacterFavouriteList(),
      SerieFavouriteList(),
      ComicFavouriteList(),
      EventFavouriteList(),
      CreatorFavouriteList(),
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        child: Text(
          'Animes',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
      ),
      AnimeFavouriteList(),
    ]);
  }
}
