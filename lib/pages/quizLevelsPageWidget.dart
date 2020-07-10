import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/pages/HomeIconButtonWidget.dart';
import 'package:mult_tables/pages/QuizQuestionsWidget.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';
import 'package:nice_button/nice_button.dart';

class QuizLevelsPageWidget extends StatelessWidget {
  const QuizLevelsPageWidget({
    Key key,
  }) : super(key: key);

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
          title: Text('Quiz',style: TextStyle(
              fontFamily: 'Fondamento',
            ),),
          actions: <Widget>[
            HomeIconButtonWidget(),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NiceButton(
              radius: 30,
              padding: const EdgeInsets.all(10),
              text: '$levelEasy (0 to 5)',
              fontSize: 18,
              icon: Icons.child_friendly,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                navigateToQuiz(context, Level.Easy);
              },
            ),
            NiceButton(
              radius: 30,
              padding: const EdgeInsets.all(10),
              text: '$levelMedium (5 to 12)',
              fontSize: 18,
              icon: Icons.child_care,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                navigateToQuiz(context, Level.Medium);
              },
            ),
            NiceButton(
              radius: 30,
              padding: const EdgeInsets.all(10),
              text: '$levelDiff (8 to 15)',
              fontSize: 18,
              icon: Icons.person,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                navigateToQuiz(context, Level.Difficult);
              },
            ),
          ],
        )),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }

  void navigateToQuiz(BuildContext context, Level level) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      title: 'Ready for Quiz?',
      desc:
          'You have selected the ${level == Level.Easy ? 'Easy' : level == Level.Medium ? 'Medium' : 'Difficult'} level. There will be ${QuizQuestionsWidgetState.countOfQuestions} questions in the quiz and you will have ${QuizQuestionsWidgetState.countDownTime} seconds for each question. \n All the best!',
      btnOkText: 'Go',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizQuestionsWidget(level)),
        );
      },
    )..show();
  }
}
