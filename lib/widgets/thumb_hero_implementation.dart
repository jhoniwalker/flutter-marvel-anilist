import 'package:flutter/material.dart';
import '../models/thumbnail.dart';

class ThumbHeroImplementation extends StatelessWidget {
  const ThumbHeroImplementation({
    Key key,
    @required this.thumb,
  }) : super(key: key);

  final Thumbnail thumb;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        top: 20.0,
      ),
      width: thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_MEDIUM].width,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                thumb.getSizedThumb(ThumbnailSize.PORTRAIT_UNCANNY))),
      ),
    );
  }
}
