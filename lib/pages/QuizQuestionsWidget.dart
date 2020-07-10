import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/model/quizData.dart';
import 'package:mult_tables/pages/HomeIconButtonWidget.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';
import 'package:mult_tables/pages/resultsPage.dart';

class QuizQuestionsWidget extends StatefulWidget {
  final Level quizLevel;

  QuizQuestionsWidget(this.quizLevel);

  @override
  QuizQuestionsWidgetState createState() => QuizQuestionsWidgetState();
}

class QuizQuestionsWidgetState extends State<QuizQuestionsWidget> {
  static const countOfQuestions = 8;
  Level level; // = widget.quizLevel;
  Quiz quiz = null; //Quiz(countOfQuestions, 17, 0, true);
  var question = '';
  int questionNo = 0;
  int answer = 0;
  int selected = -1;
  double _progressValue = 0;
  static const int countDownTime = 10;

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
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Quiz : $levelDesc',
            style: TextStyle(
              fontFamily: 'Fondamento',
            ),
          ),
          actions: <Widget>[
            HomeIconButtonWidget(),
          ],
        ),
        body: Container(
            color: Theme.of(context).secondaryHeaderColor,
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
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
              //TODO: add a line seperator
              new Text(
                '$q1',
                style: GoogleFonts.rumRaisin(
                  fontSize: 40,
                  color: Colors.deepOrange,
                ),
                // style: TextStyle(
                //   fontSize: 22,
                //   color: Colors.deepOrange,
                // ),
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
                    initialTimer: countDownTime,

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
    quiz.questions[questionNo].time = countDownTime - timeInSeconds;
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
