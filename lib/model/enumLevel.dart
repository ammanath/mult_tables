import 'package:flutter/material.dart';

enum Level { Easy, Medium, Difficult }


AppBar buildAppBar(BuildContext context, String titleStr, Widget pageWidget) {

    return AppBar(
        title: Text(titleStr),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.question_answer),
          color: Colors.lime[700],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => pageWidget),);
          },
        ),]);
  }
