import 'package:flutter/material.dart';
import 'package:mult_tables/pages/appBarProvider.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';
import 'package:mult_tables/pages/resultsCellWidget.dart';

class TablePageWidget extends StatelessWidget {
  final int multBy;

  const TablePageWidget(
    this.multBy, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            buildAppBar(context, 'Multi Tables for $multBy', QuizLevelsPageWidget()),
        body: Center(
          child: TableBodyWidget(multBy),
        ),
      ),
    );
  }
}

class TableBodyWidget extends StatelessWidget {
  final int multBy;

  const TableBodyWidget(
    this.multBy, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: GridWidget(multBy),
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget(
    this.multBy, {
    Key key,
  }) : super(key: key);
  final int multBy;
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 120,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(28, multBy, context));
  }

  List<Widget> _buildGridTileList(
          int count, int multBy, BuildContext context) =>
      generateCells(count, multBy, context);

  List<Widget> generateCells(int count, int multBy, BuildContext context) {
    return List.generate(count, (i) => generateCell(i, multBy, context));
  }

  InkWell generateCell(int i, int multBy, BuildContext context) {
    var cellText = getCellText(i, multBy);
    var container = ResultsCellWidget(
        multiplyFor: multBy, multiplier:i + 2 , result: (i + 2) * multBy);
    return InkWell(
      child: container,
      // onTap: () => tapAction(i, multBy, cellText, context),
    );
  }

  String getCellText(int i, int multBy) {
    int num = i + 2;
    var result = num * multBy;

    return ' * $num = ${(result).toString()}';
  }

  
}
