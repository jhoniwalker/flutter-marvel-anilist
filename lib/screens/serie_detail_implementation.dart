import 'package:actividad_05/models/serie.dart';
//import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/screens/serie_detail/serie_releated_content.dart';
//import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
//import 'package:actividad_05/widgets/labeled_image_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SerieDetailScreenImplementation extends StatefulWidget {
  const SerieDetailScreenImplementation({Key key, this.serie})
      : super(key: key);

  final Serie serie;

  @override
  _SerieDetailScreenImplementationState createState() =>
      _SerieDetailScreenImplementationState();
}

class _SerieDetailScreenImplementationState
    extends State<SerieDetailScreenImplementation> {
  List<dynamic> favouritedSeries = [];

  toggleFavourite(Serie serie) => () async {
        setState(() {
          if (favouritedSeries.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == serie.id,
                  orElse: () => null) !=
              null) {
            favouritedSeries.removeWhere((item) => item['id'] == serie.id);
          } else {
            favouritedSeries.add({
              'id': serie.id,
              'title': serie.title,
              'thumbnail': serie.thumbnail,
              'urls': serie.urls,
            });
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteSeries = prefs.getString('favouriteSeries') ?? '[]';

          print('From sharedProps $favouriteSeries');

          List<dynamic> favouriteSerieList = json.decode(favouriteSeries);

          if (favouriteSerieList.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == serie.id,
                  orElse: () => null) !=
              null) {
            favouriteSerieList.removeWhere((item) => item['id'] == serie.id);
          } else {
            favouriteSerieList.add({
              'id': serie.id,
              'title': serie.title,
              'thumbnail': serie.thumbnail,
              'urls': serie.urls,
            });
          }

          await prefs.setString(
              'favouriteSeries', json.encode(favouriteSerieList));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteSeries() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteSeries = prefs.getString('favouriteSeries') ?? '[]';
      List<dynamic> serieFavourites = json.decode(favouriteSeries);

      print('From INIT STATE $serieFavourites');
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
    final serie = ModalRoute.of(context).settings.arguments as Serie;

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
          DetailHeroWithBackBtn(thumbnail: serie.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: toggleFavourite(serie != null ? serie : null),
                icon: (favouritedSeries.firstWhere(
                            (itemToCheck) => itemToCheck['id'] == serie.id,
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
                serie.title.toUpperCase(),
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
                    serie.description,
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
          SerieReleatedContent(
            serie: serie,
          ),
          Attribution(),
        ],
      ),
    );
  }
}
