import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('text'),
    );
  }
}
