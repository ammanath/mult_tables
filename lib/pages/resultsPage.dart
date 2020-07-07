import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/model/quizData.dart';
import 'package:mult_tables/pages/homePageWidget.dart';
import 'package:mult_tables/pages/quizPageWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatelessWidget {
  final Quiz quiz;
  ResultsPage({Key key, @required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getSettingsAndAct();
    return new WillPopScope(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
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
                Navigator.pushAndRemoveUntil(context, route, (_) => false);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            QuizResultsTableWidget(quiz: quiz),
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

class QuizResultsTableWidget extends StatelessWidget {
  const QuizResultsTableWidget({
    Key key,
    @required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    var table = DataTable(columns: [
      DataColumn(label: Text('Question')),
      DataColumn(label: Text('Answer')),
      DataColumn(label: Text('Correct Ans')),
      DataColumn(label: Text('Result')),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Dash')),
        DataCell(Text('Dash')),
        DataCell(Text('Dash')),
        DataCell(Text('Dash')),
      ])
    ]);
    return Text(
        'Results : ${quiz?.totalScore} right from ${quiz?.countOfQuestions} questions, completed in ${quiz?.totalTime} seconds');
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
