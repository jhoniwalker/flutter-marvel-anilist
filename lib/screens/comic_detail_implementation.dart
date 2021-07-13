import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/screens/comic_detail/comic_releated_content.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ComicDetailScreenImplementation extends StatefulWidget {
  const ComicDetailScreenImplementation({Key key, this.comic})
      : super(key: key);

  final Comic comic;

  @override
  _ComicDetailScreenImplementationState createState() =>
      _ComicDetailScreenImplementationState();
}

class _ComicDetailScreenImplementationState
    extends State<ComicDetailScreenImplementation> {
  List<dynamic> favouritedComics = [];

  toggleFavourite(Comic comic) => () async {
        setState(() {
          if (favouritedComics.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == comic.id,
                  orElse: () => null) !=
              null) {
            favouritedComics.removeWhere((item) => item['id'] == comic.id);
          } else {
            favouritedComics.add({
              'id': comic.id,
              'title': comic.title,
              'thumbnail': comic.thumbnail,
              'urls': comic.urls,
              'images': comic.images
            });
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteComics = prefs.getString('favouriteComics') ?? '[]';

          print('From sharedProps $favouriteComics');

          List<dynamic> favouriteComicList = json.decode(favouriteComics);

          if (favouriteComicList.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == comic.id,
                  orElse: () => null) !=
              null) {
            favouriteComicList.removeWhere((item) => item['id'] == comic.id);
          } else {
            favouriteComicList.add({
              'id': comic.id,
              'title': comic.title,
              'thumbnail': comic.thumbnail,
              'urls': comic.urls,
              'images': comic.images
            });
          }

          await prefs.setString(
              'favouriteComics', json.encode(favouriteComicList));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteComics() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteComics = prefs.getString('favouriteComics') ?? '[]';
      List<dynamic> comicFavourites = json.decode(favouriteComics);

      print('From INIT STATE $comicFavourites');
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
    final comic = ModalRoute.of(context).settings.arguments as Comic;
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
          DetailHeroWithBackBtn(thumbnail: comic.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: toggleFavourite(comic != null ? comic : null),
                icon: (favouritedComics.firstWhere(
                            (itemToCheck) => itemToCheck['id'] == comic.id,
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
                comic.title.toUpperCase(),
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
                    comic.description,
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
          ComicReleatedContent(
            comic: comic,
          ),
          Attribution(),
        ],
      ),
    );
  }
}
