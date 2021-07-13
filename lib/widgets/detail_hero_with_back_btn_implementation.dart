import 'package:actividad_05/models/thumbnail.dart';
import 'package:flutter/material.dart';

class DetailHeroWithBackBtnImplementation extends StatelessWidget {
  const DetailHeroWithBackBtnImplementation({Key key, this.thumbnail})
      : super(key: key);

  final Thumbnail thumbnail;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(60, 40),
              bottomRight: Radius.elliptical(60, 40)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  thumbnail.getSizedThumb(ThumbnailSize.LANDSCAPE_XLARGE))),
        ),
      ),
      Container(
        width: double.infinity,
        height: 200,
        child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.white,
            )),
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.center,
              colors: [
                Colors.black45,
                Colors.black38.withAlpha(0),
              ],
            )),
      )
    ]);
  }
}
