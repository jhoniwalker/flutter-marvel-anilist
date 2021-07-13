import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';

class CreatorFavouriteList extends StatefulWidget {
  const CreatorFavouriteList({Key key}) : super(key: key);

  @override
  _CreatorFavouriteList createState() => _CreatorFavouriteList();
}

class _CreatorFavouriteList extends State<CreatorFavouriteList> {
  List<dynamic> favouritedCreators = [];

  getFavouriteCreators() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteCreators = prefs.getString('favouriteCreators') ?? '[]';
      List<dynamic> creatorFavourites = json.decode(favouriteCreators);
      setState(() {
        favouritedCreators = creatorFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteCreators();
  }

  @override
  Widget build(BuildContext context) {
    List<Creator> creators =
        favouritedCreators.map((item) => Creator.fromJson(item)).toList();

    List<Thumbnail> thumbs = favouritedCreators
        .map((item) => Thumbnail.fromJson(item['thumbnail']))
        .toList();

    return LabeledImageList(
        onTap: (index) => () => {
              Navigator.pushNamed(context, ROUTE_NAMES['CREATOR_DETAIL'],
                      arguments: creators[index])
                  .then((_) => setState(() {
                        getFavouriteCreators()();
                      }))
            },
        label: "Favs creators",
        thumbs: thumbs);
  }
}
