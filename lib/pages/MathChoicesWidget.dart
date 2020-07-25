import 'package:flutter/material.dart';
import 'package:mult_tables/model/enumLevel.dart';
import 'package:mult_tables/model/mult__icons_icons.dart';
import 'package:mult_tables/pages/aboutButtonWidget.dart';
import 'package:mult_tables/pages/multTablesHomePageWidget.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';
import 'package:mult_tables/pages/reviewButtonWidget.dart';
import 'package:nice_button/nice_button.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
//import 'package:image/image.dart' as imageUtils;

class MathChoices extends StatelessWidget {
  static const firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Math',
          style: TextStyle(
            fontFamily: 'Fondamento',
          ),
        ),
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
          ReviewButton(),
          AboutButton(),
        ],
      ),
      body: Center(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bkg1.jfif"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.yellow.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NiceButton(
                radius: 30,
                padding: const EdgeInsets.all(8),
                text: 'Addition',
                fontSize: 18,
                icon: Mult_Icons.plus_outline,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          QuizLevelsPageWidget(operation: OpType.Add));
                  Navigator.pushAndRemoveUntil(context, route, (_) => false);
                }),
            NiceButton(
                radius: 30,
                padding: const EdgeInsets.all(8),
                text: 'Subtraction',
                fontSize: 18,
                icon: Mult_Icons.minus_outline,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          QuizLevelsPageWidget(operation: OpType.Subtract));
                  Navigator.pushAndRemoveUntil(context, route, (_) => false);
                }),
            NiceButton(
                radius: 30,
                padding: const EdgeInsets.all(8),
                text: 'Multiplication',
                fontSize: 18,
                icon: Mult_Icons.cancel_outline,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          QuizLevelsPageWidget(operation: OpType.Multiply));
                  Navigator.pushAndRemoveUntil(context, route, (_) => false);
                }),
            NiceButton(
                radius: 30,
                padding: const EdgeInsets.all(8),
                text: 'Divide',
                fontSize: 18,
                icon: Mult_Icons.divide_outline,
                // Icon(Mult_Icons.divide),
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          QuizLevelsPageWidget(operation: OpType.Divide));
                  Navigator.pushAndRemoveUntil(context, route, (_) => false);
                }),
          ],
        ),
      )),
    );
  }
}
