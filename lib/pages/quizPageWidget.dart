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
  final quiz = Quiz(5, 7, 0, true);
  var score = 0;
  var question = '';
  int questionNo = 0;

  @override
  Widget build(BuildContext context) {
    question = 'Q$questionNo : ${quiz.firstListOfNumbers[questionNo]} * ${quiz.secondListOfNumbers[questionNo]} = ';
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(20.0)),
                new Text(widget.level),
                new Text('Score : $score'),
                new Text('Q: $question'),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      child: new Text('Choice 1'),
                      onPressed: null,
                      minWidth: 120.0,
                    ),
                    MaterialButton(
                      child: new Text('Choice 2'),
                      onPressed: null,
                      minWidth: 120.0,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      child: new Text('Choice 3'),
                      onPressed: null,
                      minWidth: 120.0,
                    ),
                    MaterialButton(
                      child: new Text('Choice 4'),
                      onPressed: null,
                      minWidth: 120.0,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  RaisedButton(
                    child: new Text('Next'),
                    onPressed: updateQuestion(),
                    color: Colors.red,
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
                          if(questionNo == quiz.countOfQuestions-1){
                            Dialog(child: Text('End!'));
                          }else{
                            questionNo++;
                          }
                        });

                      }
}
