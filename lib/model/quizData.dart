import 'dart:math';

class Quiz {
  

  var allow12and21;
  var countOfQuestions;
  var levelOfQuiz;
  final startLevel; //= _result[0];

  var _result; //= getListForQuiz(5, 7, 0, true);
  var firstListOfNumbers, secondListOfNumbers;

  Quiz(this.countOfQuestions, this.levelOfQuiz, this.startLevel,
      this.allow12and21){
       _result = _getListForQuiz(countOfQuestions, levelOfQuiz, startLevel, allow12and21);
      firstListOfNumbers = _result[0];
      secondListOfNumbers = _result[1];
      }

List<int> getPossibleResults(int i, int j){
  List<int> results = [];
  results = List.generate(4, (index ) => i*j*Random().nextInt(index+i+j));
  List<int> right = [i*j];
  int index = Random().nextInt(4);
  results.replaceRange(index, index, right);
  return null;
}

// @param const countOfQuestions = 5; This is the length of the List returned
// const levelOfQuiz = 7; //random generator upto this level (not inclusive). Max number in the quiz
// const startLevel = 0; //lowest digit in the quiz, Min number in the quiz
// const allow12and21 = true;
  List<List> _getListForQuiz(int countOfQuestions, int levelOfQuiz,
      int startLevel, bool allow12and21) {
    var l1 = <int>[];
    var l2 = <int>[];

    final _random = Random();
    var _resultList = <String>[];

    var _t1, _t2, _comb, _effort = 0;
    while (l1.length < countOfQuestions && _effort < 100) {
      _effort++;
      _t1 = _random.nextInt(levelOfQuiz);
      if (_t1 < startLevel) {
        _t1 = _t1 + startLevel;
      }
      _t2 = _random.nextInt(levelOfQuiz);
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
