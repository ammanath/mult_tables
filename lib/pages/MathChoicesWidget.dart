import 'package:flutter/material.dart';
import 'package:mult_tables/pages/aboutButtonWidget.dart';
import 'package:mult_tables/pages/quizIconButtonWidget.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';
import 'package:mult_tables/pages/reviewButtonWidget.dart';
import 'package:nice_button/nice_button.dart';

class MathChoices extends StatelessWidget {
  static const firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Math',
            style: TextStyle(
              fontFamily: 'Fondamento',
            ),
          ),
          actions: <Widget>[
            QuizIconButtonWidget(),
            ReviewButton(),
            AboutButton(),
          ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NiceButton(
            radius: 30,
            padding: const EdgeInsets.all(8),
            text: 'Addition',
            fontSize: 18,
            icon: Icons.plus_one,
            gradientColors: [Colors.black, Colors.grey],
            onPressed: () {},
          ),
          NiceButton(
            radius: 30,
            padding: const EdgeInsets.all(8),
            text: 'Subtraction',
            fontSize: 18,
            icon: Icons.minimize,
            gradientColors: [Colors.black, Colors.grey],
            onPressed: () {},
          ),
          NiceButton(
            radius: 30,
            padding: const EdgeInsets.all(8),
            text: 'Multiplication',
            fontSize: 18,
            icon: Icons.multiline_chart,
            gradientColors: [secondColor, firstColor],
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => QuizLevelsPageWidget());
              Navigator.pushAndRemoveUntil(context, route, (_) => false);
            },
          ),
          NiceButton(
            radius: 30,
            padding: const EdgeInsets.all(8),
            text: 'Division',
            fontSize: 18,
            icon: Icons.drive_eta,
            gradientColors: [Colors.black, Colors.grey],
          ),
        ],
      )),
    );
  }
}
