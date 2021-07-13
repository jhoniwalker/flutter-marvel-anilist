import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/text_with_icon.dart';

class AnimeFavouriteList extends StatefulWidget {
  const AnimeFavouriteList({Key key}) : super(key: key);

  @override
  _AnimeFavouriteList createState() => _AnimeFavouriteList();
}

class _AnimeFavouriteList extends State<AnimeFavouriteList> {
  List<dynamic> favouritedAnimeIds = [];
  List<dynamic> media = [];

  getFavouriteAnimes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteAnimes = prefs.getString('favouriteAnimes') ?? '[]';
      List<dynamic> AnimeFavourites = json.decode(favouriteAnimes);
      setState(() {
        favouritedAnimeIds = AnimeFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouriteAnimes();
  }

  final String queryAnime = r"""
    query ($id_in: [Int], $perPage: Int) {
      favourites: Page(page: 1, perPage: $perPage) {
          media(id_in: $id_in, type: ANIME, isAdult: false) {
            id
            title {
              userPreferred
            }
            coverImage {
              large
            }
          }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(queryAnime),
            variables: {"id_in": favouritedAnimeIds, "perPage": 20},
            fetchPolicy: FetchPolicy.noCache),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            print(result.exception);
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Text('Cargango...');
          }

          return Column(
            children: [
              TextWithIcon(label: 'Favs Animes'),
              Container(
                height: 240,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: result.data['favourites']['media'].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, ROUTE_NAMES['ANIME_DETAIL'],
                                    arguments: result.data['favourites']
                                        ['media'][index])
                                .then((_) => setState(() {
                                      getFavouriteAnimes();
                                    }));
                          },
                          child: AnimeCard(
                              media: result.data['favourites']['media']
                                  [index]));
                    }),
              ),
            ],
          );
        });
  }
}

class AnimeCard extends StatelessWidget {
  const AnimeCard({
    Key key,
    @required this.media,
  }) : super(key: key);

  final dynamic media;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(left: 15, bottom: 10, top: 5),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 6,
                color: Colors.black54.withOpacity(0.25))
          ],
          image: DecorationImage(
            image: NetworkImage(media['coverImage']['large']),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      Container(
          margin: EdgeInsets.only(left: 15, bottom: 10),
          width: 150,
          child: Text(
            media['title']['userPreferred'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          )),
    ]);
  }
}
