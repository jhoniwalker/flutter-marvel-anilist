import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';

class ComicFavouriteList extends StatefulWidget {
  const ComicFavouriteList({Key key}) : super(key: key);

  @override
  _ComicFavouriteList createState() => _ComicFavouriteList();
}

class _ComicFavouriteList extends State<ComicFavouriteList> {
  List<dynamic> favouritedComics = [];

  getFavouriteComics() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteComics = prefs.getString('favouriteComics') ?? '[]';
      List<dynamic> comicFavourites = json.decode(favouriteComics);
      setState(() {
        favouritedComics = comicFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteComics();
  }

  @override
  Widget build(BuildContext context) {
    List<Comic> comics =
        favouritedComics.map((item) => Comic.fromJson(item)).toList();

    List<Thumbnail> thumbs = favouritedComics
        .map((item) => Thumbnail.fromJson(item['thumbnail']))
        .toList();

    print(comics);

    return LabeledImageList(
        onTap: (index) => () => {
              Navigator.pushNamed(context, ROUTE_NAMES['COMIC_DETAIL'],
                      arguments: comics[index])
                  .then((_) => setState(() {
                        getFavouriteComics();
                      }))
            },
        label: "Favs comics",
        thumbs: thumbs);
  }
}
