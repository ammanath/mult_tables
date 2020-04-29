import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Tables',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multi Tables'),
        ),
        body: Center(
          child: MainBodyWidget(),
        ),
      ),
    );
  }
}

class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,

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
        children: _buildGridTileList(99,context));
  }

  List<Widget> _buildGridTileList(int count,BuildContext context) => generateCells(count, context);

  List<Widget> generateCells(int count,BuildContext context) {
    return List.generate(count, (i) => generateCell(i,context));
  }

  InkWell generateCell(int i,BuildContext context) {
    var cellText = getCellText(i);
    return InkWell(
      child: Container(
          color: Colors.lime[200], child: Center(child: Text(cellText))),
      onTap: () => tapAction(cellText,context),
    );
  }

  void tapAction(String cellText,BuildContext context) {
    print("Container pressed $cellText");
    int cellNo = int.parse(cellText);
    print(context);
    var gvw = context ;
    print(gvw.widget.createElement());
  }

  String getCellText(int i) => (i + 2).toString();
}
