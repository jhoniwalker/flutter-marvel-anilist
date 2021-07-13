import 'package:actividad_05/models/character.dart';
//import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/screens/character_detail/character_releated_content.dart';
import 'package:actividad_05/services/favourites_service.dart';
//import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
//import 'package:actividad_05/widgets/labeled_image_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({Key key}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  List<dynamic> favouritedCharacters = [];
  List<int> favouritedCharacterIdsSqlite = [];

  toggleFavouriteSqlite(Character character) => () async {
        setState(() {
          if (favouritedCharacterIdsSqlite.indexOf(character.id) >= 0) {
            favouritedCharacterIdsSqlite.remove(character.id);
            FavouritesService().deleteCharacter(character);
          } else {
            favouritedCharacterIdsSqlite.add(character.id);
            FavouritesService().insertCharacter(character);
          }
        });
      };

  getFavouriteCharactersSqlite() async {
    try {
      List<int> favCharIds = await FavouritesService().getFavouriteCharacters();
      print("getFavouriteCharactersSqlite ${favCharIds.toString()}");
      setState(() {
        favouritedCharacterIdsSqlite = favCharIds;
      });
    } catch (e) {
      print('getFavouriteCharactersSqlite $e');
    }
  }

  toggleFavourite(Character character) => () async {
        setState(() {
          if (favouritedCharacters.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == character.id,
                  orElse: () => null) !=
              null) {
            favouritedCharacters
                .removeWhere((item) => item['id'] == character.id);
          } else {
            favouritedCharacters.add({
              'id': character.id,
              'name': character.name,
              'description': character.description,
              'thumbnail': character.thumbnail,
            });
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteCharacters =
              prefs.getString('favouriteCharacters') ?? '[]';

          print('From sharedProps $favouriteCharacters');

          List<dynamic> favouriteCharacterList =
              json.decode(favouriteCharacters);

          if (favouriteCharacterList.firstWhere(
                  (itemToCheck) => itemToCheck['id'] == character.id,
                  orElse: () => null) !=
              null) {
            favouriteCharacterList
                .removeWhere((item) => item['id'] == character.id);
          } else {
            favouriteCharacterList.add({
              'id': character.id,
              'name': character.name,
              'description': character.description,
              'thumbnail': character.thumbnail,
            });
          }

          await prefs.setString(
              'favouriteCharacters', json.encode(favouriteCharacterList));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteCharacters() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteCharacters =
          prefs.getString('favouriteCharacters') ?? '[]';
      List<dynamic> characterFavourites = json.decode(favouriteCharacters);

      print('From INIT STATE $characterFavourites');
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
    //getFavouriteCharactersSqlite();
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context).settings.arguments as Character;

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
          DetailHeroWithBackBtn(thumbnail: character.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed:
                    toggleFavourite(character != null ? character : null),
                icon: (favouritedCharacters.firstWhere(
                            (itemToCheck) => itemToCheck['id'] == character.id,
                            orElse: () => null) !=
                        null)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline),
                iconSize: 40.0,
                color: Colors.black,
              ),
              IconButton(
                onPressed:
                    toggleFavouriteSqlite(character != null ? character : null),
                icon: (favouritedCharacterIdsSqlite
                            .indexOf(character != null ? character.id : 0) >=
                        0)
                    ? Icon(Icons.star)
                    : Icon(Icons.star_outline),
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
                character.name.toUpperCase(),
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
                    character.description,
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
          CharacterReleatedContent(
            character: character,
          ),
          Attribution(),
        ],
      ),
    );
  }
}
