import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mult_tables/model/quizData.dart';

class QuizPageWidget extends StatelessWidget {
  const QuizPageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var level = 'Easy';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizQuestionsWidget(level)),
                );
              },
              child: Text(level),
            ),
            RaisedButton(
              onPressed: null,
              child: Text('Medium'),
            ),
            RaisedButton(
              onPressed: null,
              child: Text('Difficult'),
            ),
          ],
        )),
      ),
    );
  }
}

class QuizQuestionsWidget extends StatefulWidget {
  final level;

  QuizQuestionsWidget(this.level);

  @override
  _QuizQuestionsWidgetState createState() => _QuizQuestionsWidgetState();
}

class _QuizQuestionsWidgetState extends State<QuizQuestionsWidget> {
  final quiz = Quiz(5, 17, 0, true);
  var score = 0;
  var question = '';
  int questionNo = 0;
  int answer = 0;
  int selected=-1;
  @override
  Widget build(BuildContext context) {
    question =
        'Q${questionNo + 1} : ${quiz.firstListOfNumbers[questionNo]} * ${quiz.secondListOfNumbers[questionNo]} = ';
    
    List<int> results = quiz.arrayOfPossibleResults[questionNo];

    answer = quiz.firstListOfNumbers[questionNo] *
        quiz.secondListOfNumbers[questionNo];
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(20.0)),
                new Text('Level : ${widget.level}'),
                new Text('Score : $score'),
                new Text('$question'),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      child: new Text('Choice 1: ${results[0]}'),
                      onPressed: () {
                        choiceSelected(results[0]);
                      },
                      color: selected==results[0]?Colors.teal:Colors.blueGrey,
                      
                      minWidth: 120.0,
                    ),
                    MaterialButton(
                      child: new Text('Choice 2: ${results[1]}'),
                      onPressed: () {
                        choiceSelected(results[1]);
                      },
                      color: selected==results[1]?Colors.teal:Colors.blueGrey,
                      minWidth: 120.0,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      child: new Text('Choice 3: ${results[2]}'),
                      onPressed: () {
                        choiceSelected(results[2]);
                      },
                      color: selected==results[2]?Colors.teal:Colors.blueGrey,
                      minWidth: 120.0,
                    ),
                    MaterialButton(
                      child: new Text('Choice 4: ${results[3]}'),
                      onPressed: () {
                        choiceSelected(results[3]);
                      },
                      color: selected==results[3]?Colors.teal:Colors.blueGrey,
                      minWidth: 120.0,
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          updateQuestion();
                        },
                        color: Colors.green,
                      ),
                    ])
              ],
            )),
      ),
    );
  }

  dynamic getAllQuizQuestions() {
    var texts = <Widget>[];
    print('In getText, level is: ${widget.level}');
    for (int i = 0; i < quiz.firstListOfNumbers.length; i++) {
      texts.add(Text(
          'Q$i : ${quiz.firstListOfNumbers[i]} * ${quiz.secondListOfNumbers[i]} = '));
    }
    return texts;
  }

  updateQuestion() {
    setState(() {
      if(answer==selected){
        score++;
      }
      if (questionNo == quiz.countOfQuestions - 1) {
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> Summary(finalScore:score)));
      } else {
        questionNo++;
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

class Summary extends StatelessWidget{
  final int finalScore;
  Summary({Key key, @required this.finalScore}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        body: Text('Summary'),
      ) ,
      onWillPop: ()async=>false,);
  }

}
