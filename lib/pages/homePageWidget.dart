import 'package:flutter/material.dart';
import 'package:mult_tables/pages/cellWidget.dart';
import 'package:mult_tables/pages/helper.dart';
import 'package:mult_tables/pages/quizPageWidget.dart';
import 'package:mult_tables/pages/tablePageWidget.dart';

class MultTablesHomePageWidget extends StatelessWidget {
  const MultTablesHomePageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(context, 'Multi Tables', QuizPageWidget()),

      body: Center(
        child: MainBodyWidget(),
      ),
    );
  }
}

//TODO:Add top menu  for feedback ratings, settings 
class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: GridWidget(),
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 120,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: generateCells(99, context),
    );
  }

  List<Widget> generateCells(int count,BuildContext context) {
    return List.generate(count, (i) => generateCell(i,context));
  }

  InkWell generateCell(int i,BuildContext context) {     
    var cellText = getCellText(i);
    return InkWell(
      child: CellWidget(cellText: cellText),
      onTap: () => tapAction(cellText,context),
    );
  }

  void tapAction(String cellText,BuildContext context) {
    print("Container pressed $cellText");
    int cellNo = int.parse(cellText);
    print(cellNo);
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => TablePageWidget(cellNo)),
    );
  }

  String getCellText(int i) => (i + 2).toString();
}
