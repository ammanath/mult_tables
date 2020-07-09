
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
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/model/quizData.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
