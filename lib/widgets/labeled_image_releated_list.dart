import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/widgets/text_with_icon.dart';
import 'package:actividad_05/widgets/thumb_hero.dart';
import 'package:flutter/material.dart';

class LabeledImageReleatedList extends StatelessWidget {
  const LabeledImageReleatedList({Key key, this.label, this.thumbs})
      : super(key: key);

  final String label;
  final List<Thumbnail> thumbs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextWithIcon(label: label),
        Container(
            height:
                thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_MEDIUM].height,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: thumbs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: ThumbHero(thumb: thumbs[index]));
                }))
      ],
    );
  }
}
