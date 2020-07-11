import 'package:flutter/material.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';

//https://stackoverflow.com/questions/53411890/how-can-i-have-my-appbar-in-a-separate-file-in-flutter-while-still-having-the-wi
class QuizAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  QuizAppBarWidget({
    Key key,
  }) : super(key: key);

  final AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Quiz Results'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          color: Theme.of(context).backgroundColor,
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => MultTablesHomePageWidget());
            Navigator.pushAndRemoveUntil(context, route, (_) => false);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

