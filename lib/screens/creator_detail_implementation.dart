import 'package:actividad_05/models/creator.dart';
//import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/screens/creator_detail/creator_releated_content.dart';
//import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
//import 'package:actividad_05/widgets/labeled_image_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CreatorDetailScreenImplementation extends StatefulWidget {
  const CreatorDetailScreenImplementation({Key key, this.creator})
      : super(key: key);

  final Creator creator;

  @override
  _CreatorDetailScreenImplementationState createState() =>
      _CreatorDetailScreenImplementationState();
}

class _CreatorDetailScreenImplementationState
    extends State<CreatorDetailScreenImplementation> {
  List<dynamic> favouritedCreators = [];

  toggleFavourite(Creator creator) => () async {
        setState(() {
          if (favouritedCreators.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == creator.id,
                  orElse: () => null) !=
              null) {
            favouritedCreators.removeWhere((item) => item['id'] == creator.id);
          } else {
            favouritedCreators.add({
              'id': creator.id,
              'fullName': creator.fullName,
              'middleName': creator.middleName,
              'thumbnail': creator.thumbnail,
              'urls': creator.urls,
            });
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteCreators =
              prefs.getString('favouriteCreators') ?? '[]';

          print('From sharedProps $favouriteCreators');

          List<dynamic> favouriteCreatorList = json.decode(favouriteCreators);

          if (favouriteCreatorList.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == creator.id,
                  orElse: () => null) !=
              null) {
            favouriteCreatorList
                .removeWhere((item) => item['id'] == creator.id);
          } else {
            favouriteCreatorList.add({
              'id': creator.id,
              'fullName': creator.fullName,
              'middleName': creator.middleName,
              'thumbnail': creator.thumbnail,
              'urls': creator.urls,
            });
          }

          await prefs.setString(
              'favouriteCreators', json.encode(favouriteCreatorList));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteCreators() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteCreators = prefs.getString('favouriteCreators') ?? '[]';
      List<dynamic> creatorFavourites = json.decode(favouriteCreators);

      print('From INIT STATE $creatorFavourites');
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
    final creator = ModalRoute.of(context).settings.arguments as Creator;

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
          DetailHeroWithBackBtn(thumbnail: creator.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: toggleFavourite(creator != null ? creator : null),
                icon: (favouritedCreators.firstWhere(
                            (itemToCheck) => itemToCheck['id'] == creator.id,
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
                creator.fullName.toUpperCase(),
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
                    creator.middleName,
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
          CreatorReleatedContent(
            creator: creator,
          ),
          Attribution(),
        ],
      ),
    );
  }
}
