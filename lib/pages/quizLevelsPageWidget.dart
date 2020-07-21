import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/pages/HomeIconButtonWidget.dart';
import 'package:mult_tables/pages/niceButtonWidget.dart';

class QuizLevelsPageWidget extends StatelessWidget {
  final String operation;

  const QuizLevelsPageWidget({Key key, this.operation = 'Multiply'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const levelEasy = 'Easy';
    const levelMedium = 'Medium';
    const levelDiff = 'Difficult';
    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Quiz',
            style: TextStyle(
              fontFamily: 'Fondamento',
            ),
          ),
          actions: <Widget>[
            HomeIconButtonWidget(),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NiceButtonWidget(
              buttonText: '$levelEasy (0 to 5)',
              level: Level.Easy,
              icon: Icons.child_friendly,
              operation: operation,
            ),
            NiceButtonWidget(
              buttonText: '$levelMedium (5 to 12)',
              level: Level.Medium,
              icon: Icons.child_care,
              operation: operation,
            ),
            NiceButtonWidget(
              buttonText: '$levelDiff (8 to 15)',
              level: Level.Difficult,
              icon: Icons.person,
              operation: operation,
            ),
          ],
        )),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
