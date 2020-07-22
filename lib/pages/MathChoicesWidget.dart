import 'package:flutter/material.dart';
import 'package:mult_tables/model/enumLevel.dart';
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NiceButton(
              radius: 30,
              padding: const EdgeInsets.all(8),
              text: 'Addition',
              fontSize: 18,
              icon: Icons.add,
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
              icon: Icons.dashboard,
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
              icon: Icons.clear,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => QuizLevelsPageWidget(operation: OpType.Multiply));
                Navigator.pushAndRemoveUntil(context, route, (_) => false);
              }),
          NiceButton(
              radius: 30,
              padding: const EdgeInsets.all(8),
              text: 'Divide',
              fontSize: 18,
              icon: Icons.dialpad,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => QuizLevelsPageWidget(operation: OpType.Divide));
                Navigator.pushAndRemoveUntil(context, route, (_) => false);
              }),
        ],
      )),
    );
  }
}

class ButtonMathOption extends StatelessWidget {
  const ButtonMathOption({Key key, this.buttonText}) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return NiceButton(
      radius: 30,
      padding: const EdgeInsets.all(8),
      text: buttonText,
      fontSize: 18,
      icon: Icons.add,
      gradientColors: [Colors.black, Colors.grey],
      onPressed: () {
        showComingSoonDialog(context);
      },
    );
  }

  void showComingSoonDialog(BuildContext context) {
    //https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/cef1cf22-f137-47b6-8167-4e4bd523b5aa/dd4gca0-6e6c16b1-8882-4822-ba66-2d226ae0f96b.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvY2VmMWNmMjItZjEzNy00N2I2LTgxNjctNGU0YmQ1MjNiNWFhXC9kZDRnY2EwLTZlNmMxNmIxLTg4ODItNDgyMi1iYTY2LTJkMjI2YWUwZjk2Yi5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ._jwsW4ICmE2WnqfFRjXFt2ceMb0Jx7regJVbrAO5Ri4

    Image img = Image.network(
        "https://github.com/ammanath/Images/blob/master/comingSoon.gif");
    // var encodedImage = Image.memory(
    //           imageUtils.encodePng(img));

    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: img,
              title: Text('Coming Soon!!!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                'This functionality will be available soon!',
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.BOTTOM_LEFT,
              onOkButtonPressed: () {
                Navigator.pop(context);
              },
              onlyOkButton: true,
            ));
  }
}
