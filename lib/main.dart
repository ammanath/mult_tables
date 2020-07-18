import 'package:flutter/material.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.cyan[100],
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: MultTablesHomePageWidget(),
        //child: AnimateBrij(),
      ),
    );
  }
}

class AnimateBrij extends StatefulWidget {
  @override
  _AnimateBrijState createState() => _AnimateBrijState();
}

class _AnimateBrijState extends State<AnimateBrij> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.asset('assets/images/congrats.gif'),
        ),
        Container(
          child: Image.asset('assets/images/lost.gif'),
          height: 150,
          width: 150,
        ),
      ],
    );
  }
}
