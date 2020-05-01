
import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({
    Key key,
    @required this.cellText,
  }) : super(key: key);

  final String cellText;

  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.lime[200], child: Center(child: Text(cellText)));
  }
}