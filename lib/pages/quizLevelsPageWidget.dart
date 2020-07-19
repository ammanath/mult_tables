import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/pages/HomeIconButtonWidget.dart';
import 'package:mult_tables/pages/QuizQuestionsWidget.dart';
import 'package:mult_tables/pages/niceButtonWidget.dart';
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
            NiceButtonWidget(buttonText: '$levelEasy (0 to 5)', level: Level.Easy,icon:Icons.child_friendly),
            NiceButtonWidget(buttonText: '$levelMedium (5 to 12)', level: Level.Medium,icon:Icons.child_care),
            NiceButtonWidget(buttonText: '$levelDiff (8 to 15)', level: Level.Difficult,icon:Icons.person),
            
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