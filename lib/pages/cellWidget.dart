import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({
    Key key,
    @required this.cellText,
  }) : super(key: key);

  final String cellText;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Text(cellText,
          style: GoogleFonts.kalam(fontSize: 26, color: Colors.black),),
        ));
  }
}
