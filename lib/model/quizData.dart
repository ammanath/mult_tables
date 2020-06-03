import 'dart:math';
import 'package:mult_tables/model/enumLevel.dart';

class Quiz {
  var allow12and21;
  var countOfQuestions;
  Level levelOfQuiz;
  final startLevel; //= _result[0];

  var _result; //= getListForQuiz(5, 7, 0, true);
  var firstListOfNumbers, secondListOfNumbers;
  List<List<int>> arrayOfPossibleResults=[];

  Quiz(this.countOfQuestions, this.levelOfQuiz, this.startLevel,
      this.allow12and21) {
    _result = _getListForQuiz(
        countOfQuestions, levelOfQuiz, startLevel, allow12and21);
    firstListOfNumbers = _result[0];
    secondListOfNumbers = _result[1];
    for(int i=0;i<countOfQuestions;i++){
      arrayOfPossibleResults.add(getPossibleResults(firstListOfNumbers[i],     secondListOfNumbers[i]));
    }
    
  }

  List<int> getPossibleResults(final int firstNo, final int secondNo) {
    List<int> results = [];
    const int listLength = 4;

    results = List.generate(
        listLength,
        (index) =>
            firstNo * secondNo + Random().nextInt(secondNo + listLength));
    print('Initial results : $results');
    //ensure list has unique numbers - no repeats
    //remove duplicate
    List<int> uniqueResults = [
      ...{...results}
    ];
    print('Unique results : $uniqueResults');
    if (results.length != uniqueResults.length) {
      int noOfDuplicates = results.length - uniqueResults.length;
      int value = Random().nextInt(100);
      print('NoOfDuplicates : $noOfDuplicates, value: $value');
      for (int i = 0; i < noOfDuplicates; i++) {
        if (!uniqueResults.contains(value)) {
          uniqueResults.add(value);
          print('Added $value to uniqueResults');
        } else {
          var nextInt = Random().nextInt(1000);
          uniqueResults.add(value + nextInt);
          print('Added $value + $nextInt to uniqueResults');
        }
      }
    }

    final int answer = firstNo * secondNo;
    List<int> right = [answer];
    if (!uniqueResults.contains(answer)) {
      int index = Random().nextInt(4);
      uniqueResults.replaceRange(index, index, right);
      print('Inserting right answer, $answer at index: $index');
    }
    return uniqueResults;
  }

// @param const countOfQuestions = 5; This is the length of the List returned
// const levelOfQuiz = enum.index *10 + 10; //random generator upto this level (not inclusive). Max number in the quiz
// const startLevel = 0; //lowest digit in the quiz, Min number in the quiz
// const allow12and21 = true;
  List<List> _getListForQuiz(int countOfQuestions, Level levelOfQuiz,
      int startLevel, bool allow12and21) {

    //TODO: logic to generate numbers from start level to top level
    var l1 = <int>[];
    var l2 = <int>[];

    final _random = Random();
    var _resultList = <String>[];

    var _t1, _t2, _comb, _effort = 0;

    int generateNumsUpto=(levelOfQuiz.index *10)+10;

    while (l1.length < countOfQuestions && _effort < 100) {
      _effort++;
      _t1 = _random.nextInt(generateNumsUpto);
      if (_t1 < startLevel) {
        _t1 = _t1 + startLevel;
      }
      _t2 = _random.nextInt(generateNumsUpto);
      if (_t2 < startLevel) {
        _t2 = _t2 + startLevel;
      }
      if (allow12and21) {
        _comb = '$_t1$_t2';
      } else {
        if (_t1 > _t2) {
          _comb = '$_t2$_t1';
        }
      }
      if (!_resultList.contains(_comb)) {
        _resultList.add(_comb);
        l1.add(_t1);
        l2.add(_t2);
      } else {
        print('Skipping $_comb');
      }
    }

    return [l1, l2];
  }
}
