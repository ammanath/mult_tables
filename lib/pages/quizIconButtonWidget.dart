import 'package:flutter/material.dart';
import 'package:mult_tables/pages/MathChoicesWidget.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';

class QuizIconButtonWidget extends StatelessWidget {
  const QuizIconButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.question_answer),
      color: Theme.of(context).backgroundColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              //builder: (context) => QuizLevelsPageWidget()),
              builder:(context)=> MathChoices()),
        );
      },
    );
  }
}