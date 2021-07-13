import 'package:flutter/material.dart';

class TextWithIconImplementation extends StatelessWidget {
  const TextWithIconImplementation({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        child: Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Icon(Icons.arrow_forward, size: 30),
      )
    ]);
  }
}
