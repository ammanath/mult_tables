import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar(BuildContext context, String titleStr, Widget pageWidget) {
  return AppBar(
      title: Text(
        titleStr,
        style: GoogleFonts.kalam(fontSize: 26, color: Colors.black),
      ),
      actions: <Widget>[

        IconButton(
          icon: Icon(Icons.question_answer),
          color: Theme.of(context).backgroundColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pageWidget),
            );
          },
        ),
      ]);
}

