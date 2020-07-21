import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/pages/QuizQuestionsWidget.dart';
import 'package:nice_button/nice_button.dart';



class NiceButtonWidget extends StatelessWidget {
  const NiceButtonWidget({
    Key key,
    this.operation = OpType.Multiply,
    @required this.buttonText,
    @required this.level,
    @required this.icon,
  }) : super(key: key);

  final OpType operation;
  final String buttonText;
  final Level level;
  final IconData icon;
  static const firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  @override
  Widget build(BuildContext context) {
    return NiceButton(
      radius: 30,
      padding: const EdgeInsets.all(10),
      text: buttonText,
      fontSize: 18,
      icon: icon,
      gradientColors: [secondColor, firstColor],
      onPressed: () {
        navigateToQuiz(context, level,operation);
      },
    );
  }

  void navigateToQuiz(BuildContext context, Level level, OpType operation) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      title: 'Ready for the $operation Quiz?',
      desc:
          'You have selected the ${level == Level.Easy ? 'Easy' : level == Level.Medium ? 'Medium' : 'Difficult'} level. There will be ${QuizQuestionsWidgetState.countOfQuestions} questions in the quiz and you will have ${QuizQuestionsWidgetState.countDownTime} seconds for each question. \n All the best!',
      btnOkText: 'Go',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizQuestionsWidget(level, operation)),
        );
      },
    )..show();
  }
}
