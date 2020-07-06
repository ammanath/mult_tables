import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/model/quizData.dart';
import 'package:mult_tables/pages/homePageWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPageWidget extends StatelessWidget {
  const QuizPageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const levelEasy = 'Easy';
    const levelMedium = 'Medium';
    const levelDiff = 'Difficult';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Quiz'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => MultTablesHomePageWidget());
                Navigator.pushAndRemoveUntil(context, route,(_) => false);
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                navigateToQuiz(context, Level.Easy);
              },
              child: Text('$levelEasy (0 to 5)'),
            ),
            RaisedButton(
              onPressed: () {
                navigateToQuiz(context, Level.Medium);
              },
              child: Text('$levelMedium (5 to 12)'),
            ),
            RaisedButton(
              onPressed: () {
                navigateToQuiz(context, Level.Difficult);
              },
              child: Text('$levelDiff (8 to 15)'),
            ),
          ],
        )),
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
          'You have selected the ${level == Level.Easy ? 'Easy' : level == Level.Medium ? 'Medium' : 'Difficult'} level. There will be ${_QuizQuestionsWidgetState.countOfQuestions} questions in the quiz and you will have ${_QuizQuestionsWidgetState._countDownTime} seconds for each question. \n All the best!',
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

class QuizQuestionsWidget extends StatefulWidget {
  final Level quizLevel;

  QuizQuestionsWidget(this.quizLevel);

  @override
  _QuizQuestionsWidgetState createState() => _QuizQuestionsWidgetState();
}

class _QuizQuestionsWidgetState extends State<QuizQuestionsWidget> {
  static const countOfQuestions = 8;
  Level level; // = widget.quizLevel;
  Quiz quiz = null; //Quiz(countOfQuestions, 17, 0, true);
  var question = '';
  int questionNo = 0;
  int answer = 0;
  int selected = -1;
  double _progressValue = 0;
  static const int _countDownTime = 10;

  @override
  void initState() {
    super.initState();
    this.getQuizData();
  }

  void getQuizData() {
    level = widget.quizLevel;
    quiz = Quiz(countOfQuestions, level, true);
    setState(() {
      questionNo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String levelDesc = describeEnum(level);
    question = 'Question ${questionNo + 1} of $countOfQuestions :';

    var q1 =
        '${quiz.questions[questionNo].num1} * ${quiz.questions[questionNo].num2} = ';

    List<int> results = quiz.questions[questionNo].getAllPossibleAnswers();
    _progressValue = (questionNo) / countOfQuestions;
    answer = quiz.questions[questionNo].rightAns;

    int timeL = 0;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Quiz : $levelDesc'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => MultTablesHomePageWidget());
                Navigator.pushAndRemoveUntil(context, route,(_) => false);
              },
            ),
          ],
        ),
        body: Container(
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              //new Padding(padding: EdgeInsets.all(20.0)),
              //new Text('Level : $levelDesc'),
              new Padding(padding: EdgeInsets.all(6.0)),
              new Text('Score : ${quiz.totalScore ?? 0}'),
              new Padding(padding: EdgeInsets.all(6.0)),
              new Text(
                '$question',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              new Padding(padding: EdgeInsets.all(6.0)),
              new Text(
                '$q1',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.deepOrange,
                ),
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              LinearProgressIndicator(
                value: _progressValue,
              ),
              new Padding(padding: EdgeInsets.all(20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: new Text('${results[0]}'),
                    onPressed: () {
                      choiceSelected(results[0]);
                    },
                    color:
                        selected == results[0] ? Colors.teal : Colors.blueGrey,
                    minWidth: 120.0,
                  ),
                  MaterialButton(
                    child: new Text('${results[1]}'),
                    onPressed: () {
                      choiceSelected(results[1]);
                    },
                    color:
                        selected == results[1] ? Colors.teal : Colors.blueGrey,
                    minWidth: 120.0,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: new Text('${results[2]}'),
                    onPressed: () {
                      choiceSelected(results[2]);
                    },
                    color:
                        selected == results[2] ? Colors.teal : Colors.blueGrey,
                    minWidth: 120.0,
                  ),
                  MaterialButton(
                    child: new Text('${results[3]}'),
                    onPressed: () {
                      choiceSelected(results[3]);
                    },
                    color:
                        selected == results[3] ? Colors.teal : Colors.blueGrey,
                    minWidth: 120.0,
                  )
                ],
              ),
              new Padding(padding: EdgeInsets.all(20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ArgonTimerButton(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    minWidth: MediaQuery.of(context).size.width * 0.30,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    roundLoadingShape: false,
                    splashColor: Colors.transparent,
                    onTap: (startTimer, btnState) {
                      if (questionNo != quiz.countOfQuestions - 1) {
                        startTimer(10);
                      }
                      updateQuestion(timeL);
                      print('In onTap for 1 , time left is $timeL');
                    },
                    initialTimer: _countDownTime,

                    child: Text(
                      selected == -1 ? 'Next' : 'Submit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    loader: (timeLeft) {
                      timeL = timeLeft;
                      return Text(
                        "Submit | $timeLeft",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      );
                    },
                    borderRadius: 5.0,
                    //color: Colors.transparent,
                    elevation: 0,
                  ),
                ],
              )
            ])),
      ),
    );
  }

  updateQuestion(int timeInSeconds) {
    print('In udpateQuestion, $selected');
    quiz.questions[questionNo].selected = selected;
    quiz.questions[questionNo].time = _countDownTime - timeInSeconds;
    setState(() {
      if (questionNo == quiz.countOfQuestions - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => ResultsPage(quiz: quiz)));
      } else {
        questionNo++;
        selected = -1;
      }
    });
  }

  void choiceSelected(int selection) {
    print('Choice selected: $selection');
    setState(() {
      selected = selection;
    });
  }
}

class ResultsPage extends StatelessWidget {
  final Quiz quiz;
  ResultsPage({Key key, @required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getSettingsAndAct();
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Quiz Results'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => MultTablesHomePageWidget());
                Navigator.pushAndRemoveUntil(context, route,(_) => false);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Text(
                'Results : ${quiz?.totalScore} right from ${quiz?.countOfQuestions} questions, completed in ${quiz?.totalTime} seconds'),
            //Navigate to QuizPageWidget
            RaisedButton(
                child: Text('New Quiz'),
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPageWidget()),
                      )
                    }),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Future<QuizSettings> getSettingsAndAct() async {
    _retrieveSettings();
    _saveSettings(quiz);
    QuizSettings settings = await _retrieveSettings();
    if (QuizSettings.hasNewAllTimeTopScoreBeenSet(quiz, settings)) {
      Vibrate.vibrate();
    }
    return settings;
  }

  Future<QuizSettings> _retrieveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    QuizSettings settings = QuizSettings.from(prefs);

    print(
        'Settings, Total time Quiz attempted: ${settings.totalTimesPlayed} times. Quiz was last played on ${settings.lastPlayed} at ${settings.lastLevel} and the score was ${settings.lastScore}. The count of questions was ${settings.countOfQuestions} \n The Top score at Level Easy was ${settings.allTimeBestScoreAtEasy}, \n The Top score at Level Medium was ${settings.allTimeBestScoreAtMed}, \n The Top score at Level Difficult was ${settings.allTimeBestScoreAtDiff}.');

    return settings;
  }

  _saveSettings(Quiz quiz) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    QuizSettings settings = QuizSettings.from(prefs);

    bool newAllTimeScoreSet = false;

    print(
        'Before Quiz attempted ${settings.totalTimesPlayed} times. Quiz was last played on ${settings.lastPlayed} at ${settings.lastLevel} and the score was ${settings.lastScore}. The count of questions was ${settings.countOfQuestions} \n The Top score at Level Easy was ${settings.allTimeBestScoreAtEasy}, \n The Top score at Level Medium was ${settings.allTimeBestScoreAtMed}, \n The Top score at Level Difficult was ${settings.allTimeBestScoreAtDiff}. \n This attempt set a new Top score = $newAllTimeScoreSet');

    await prefs.setInt('totalTimesPlayed', settings.totalTimesPlayed + 1);
    await prefs.setString('lastPlayed', DateTime.now().toString());
    await prefs.setInt('lastScore', quiz.totalScore);
    await prefs.setString('lastLevel', quiz.levelOfQuiz.toString());
    await prefs.setInt('countOfQuestions', quiz.countOfQuestions);

    if (QuizSettings.hasNewAllTimeTopScoreBeenSet(quiz, settings)) {
      if (quiz.levelOfQuiz == Level.Easy) {
        await prefs.setInt('allTimeBestScoreAtEasy', quiz.totalScore);
        await prefs.setString(
            'newAllTimeScoreSetAtEasy', DateTime.now().toString());
      } else if (quiz.levelOfQuiz == Level.Medium) {
        await prefs.setInt('allTimeBestScoreAtMed', quiz.totalScore);
        await prefs.setString(
            'newAllTimeScoreSetAtMed', DateTime.now().toString());
      } else if (quiz.levelOfQuiz == Level.Difficult) {
        await prefs.setInt('allTimeBestScoreAtDiff', quiz.totalScore);
        await prefs.setString(
            'newAllTimeScoreSetAtDiff', DateTime.now().toString());
      }
    }
  }
}

/*DOC: 
totalTimesPlayed - Number of times the quiz has been attempted
lastPlayed - 
lastScore
lastLevel
allTimeBestScoreAtEasy - All time best score at Level Easy
newAllTimeScoreSetAtEasy - Date and Time on when the all time best score was set at level easy.
allTimeBestScoreAtMed
newAllTimeScoreSetAtMed
allTimeBestScoreAtDiff
newAllTimeScoreSetAtDiff    
countOfQuestions
*/
class QuizSettings {
  int totalTimesPlayed;
  String lastPlayed;
  int lastScore;
  String lastLevel;
  int allTimeBestScoreAtEasy;
  int allTimeBestScoreAtMed;
  int allTimeBestScoreAtDiff;
  String newAllTimeScoreSetAtEasy;
  String newAllTimeScoreSetAtMed;
  String newAllTimeScoreSetAtDiff;
  int countOfQuestions;

  QuizSettings.from(SharedPreferences prefs) {
    totalTimesPlayed = prefs.getInt('totalTimesPlayed') ?? 0;
    lastPlayed = prefs.getString('lastPlayed');
    lastScore = prefs.getInt('lastScore') ?? 0;
    lastLevel = prefs.getString('lastLevel');
    allTimeBestScoreAtEasy = prefs.getInt('allTimeBestScoreAtEasy') ?? 0;
    allTimeBestScoreAtMed = prefs.getInt('allTimeBestScoreAtMed') ?? 0;
    allTimeBestScoreAtDiff = prefs.getInt('allTimeBestScoreAtDiff') ?? 0;
    newAllTimeScoreSetAtEasy = prefs.getString('newAllTimeScoreSetAtEasy');
    newAllTimeScoreSetAtMed = prefs.getString('newAllTimeScoreSetAtMed');
    newAllTimeScoreSetAtDiff = prefs.getString('newAllTimeScoreSetAtDiff');
    countOfQuestions = prefs.getInt('countOfQuestions') ?? 0;
  }

  static bool hasNewAllTimeTopScoreBeenSet(Quiz quiz, QuizSettings settings) {
    if (quiz.levelOfQuiz == Level.Easy) {
      if (settings.allTimeBestScoreAtEasy < quiz.totalScore) {
        return true;
      }
    } else if (quiz.levelOfQuiz == Level.Medium) {
      if (settings.allTimeBestScoreAtMed < quiz.totalScore) {
        return true;
      }
    } else if (quiz.levelOfQuiz == Level.Difficult) {
      if (settings.allTimeBestScoreAtDiff < quiz.totalScore) {
        return true;
      }
    }
    return false;
  }
}
