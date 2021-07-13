import 'package:flutter/material.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/models/thumbnail.dart';

class SerieHeroImplementation extends StatelessWidget {
  const SerieHeroImplementation({Key key, this.serie}) : super(key: key);

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].width,
        height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                serie.thumbnail.getSizedThumb(ThumbnailSize.LANDSCAPE_SMALL)),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        padding: EdgeInsets.all(5),
        width: 120,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.red.shade400,
                Colors.red.shade800.withOpacity(0.9)
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            )),
        child: Text(
          serie.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      )
    ]);
  }
}
