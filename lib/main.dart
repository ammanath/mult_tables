import 'package:flutter/material.dart';
import 'package:mult_tables/pages/aboutButtonWidget.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';
import 'package:mult_tables/pages/quizIconButtonWidget.dart';
import 'package:mult_tables/pages/reviewButtonWidget.dart';
import 'package:nice_button/nice_button.dart';

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
        //child: MathChoices(),
      ),
    );
  }
}

