import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';

class SerieFavouriteList extends StatefulWidget {
  const SerieFavouriteList({Key key}) : super(key: key);

  @override
  _SerieFavouriteList createState() => _SerieFavouriteList();
}

class _SerieFavouriteList extends State<SerieFavouriteList> {
  List<dynamic> favouritedSeries = [];

  getFavouriteSeries() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteSeries = prefs.getString('favouriteSeries') ?? '[]';
      List<dynamic> serieFavourites = json.decode(favouriteSeries);
      setState(() {
        favouritedSeries = serieFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteSeries();
  }

  @override
  Widget build(BuildContext context) {
    List<Serie> series =
        favouritedSeries.map((item) => Serie.fromJson(item)).toList();

    List<Thumbnail> thumbs = favouritedSeries
        .map((item) => Thumbnail.fromJson(item['thumbnail']))
        .toList();

    return LabeledImageList(
        onTap: (index) => () => {
              Navigator.pushNamed(context, ROUTE_NAMES['SERIE_DETAIL'],
                      arguments: series[index])
                  .then((_) => setState(() {
                        getFavouriteSeries();
                      }))
            },
        label: "Favs Series",
        thumbs: thumbs);
  }
}
