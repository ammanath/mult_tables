import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String titleStr, Widget pageWidget) {

    return AppBar(
        title: Text(titleStr),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.question_answer),
          color: Theme.of(context).backgroundColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => pageWidget),);
          },
        ),]);
  }