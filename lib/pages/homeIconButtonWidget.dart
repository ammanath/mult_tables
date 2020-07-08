import 'package:flutter/material.dart';
import 'package:mult_tables/pages/homePageWidget.dart';

class HomeIconButtonWidget extends StatelessWidget {
  const HomeIconButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.home),
      color: Theme.of(context).backgroundColor,
      onPressed: () {
        Route route = MaterialPageRoute(
            builder: (context) => MultTablesHomePageWidget());
        Navigator.pushAndRemoveUntil(context, route, (_) => false);
      },
    );
  }
}