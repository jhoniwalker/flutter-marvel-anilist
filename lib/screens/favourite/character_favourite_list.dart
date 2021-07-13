import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';

class CharacterFavouriteList extends StatefulWidget {
  const CharacterFavouriteList({Key key}) : super(key: key);

  @override
  _CharacterFavouriteList createState() => _CharacterFavouriteList();
}

class _CharacterFavouriteList extends State<CharacterFavouriteList> {
  List<dynamic> favouritedCharacters = [];

  getFavouriteCharacters() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteCharacters =
          prefs.getString('favouriteCharacters') ?? '[]';
      List<dynamic> characterFavourites = json.decode(favouriteCharacters);
      setState(() {
        favouritedCharacters = characterFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    List<Character> characters =
        favouritedCharacters.map((item) => Character.fromJson(item)).toList();

    List<Thumbnail> thumbs = favouritedCharacters
        .map((item) => Thumbnail.fromJson(item['thumbnail']))
        .toList();

    return LabeledImageList(
        onTap: (index) => () => {
              Navigator.pushNamed(context, ROUTE_NAMES['CHARACTER_DETAIL'],
                      arguments: characters[index])
                  .then((_) => setState(() {
                        getFavouriteCharacters();
                      }))
            },
        label: "Favs Characters",
        thumbs: thumbs);
  }
}
