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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: 
                getText(),
            )),
      ),
    );
  }

  dynamic getText(){
    var texts = <Widget>[];
    for (int i = 0; i < quiz.firstListOfNumbers.length; i++)
                  {
                    texts.add(Text(
                        'Q$i : ${quiz.firstListOfNumbers[i]} * ${quiz.secondListOfNumbers[i]} = '));
                  }
                  return texts;
  }

}
