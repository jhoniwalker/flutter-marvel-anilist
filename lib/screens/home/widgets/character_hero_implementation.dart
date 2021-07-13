import 'package:flutter/material.dart';
import 'package:actividad_05/models/thumbnail.dart';

import 'package:actividad_05/models/character.dart';

class CharacterHeroImplementation extends StatelessWidget {
  const CharacterHeroImplementation({Key key, this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
        width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
        height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(character.thumbnail
                  .getSizedThumb(ThumbnailSize.LANDSCAPE_XLARGE)),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black87, offset: Offset(0, 4), blurRadius: 10)
            ]),
      ),
      Container(
        margin: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
        padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
        width: 270,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.center,
              //tileMode: TileMode.decal
            )),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              character.name,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      )
    ]);
  }
}
