import 'package:flutter/material.dart';
import 'package:mult_tables/pages/cellWidget.dart';

class TablePageWidget extends StatelessWidget {
  final int cellNo;

  const TablePageWidget(this.cellNo, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Tables for $cellNo'),
      ),
      body: Center(
        child: TableBodyWidget(cellNo),
      ),
    );
  }
}

class TableBodyWidget extends StatelessWidget {
  final int cellNo;

  const TableBodyWidget(this.cellNo, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,

      child: GridWidget(cellNo),
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget(this.cellNo, {
    Key key,
  }) : super(key: key);
  final int cellNo;
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 120,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(99,cellNo,context));
  }

  List<Widget> _buildGridTileList(int count,int cellNo, BuildContext context) => generateCells(count, cellNo, context);

  List<Widget> generateCells(int count,int cellNo, BuildContext context) {
    return List.generate(count, (i) => generateCell(i,cellNo,context));
  }

  InkWell generateCell(int i,int cellNo, BuildContext context) {     
    var cellText = getCellText(i, cellNo);
    var container = CellWidget(cellText: cellText);
        return InkWell(
          child: container,
    );
  }

  String getCellText(int i, int cellNo) => ' * ${i+2} = ${((i + 2) * cellNo).toString()}';
}

