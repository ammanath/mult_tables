import 'package:flutter/material.dart';
import 'package:mult_tables/pages/aboutButtonWidget.dart';
import 'package:mult_tables/pages/cellWidget.dart';
import 'package:mult_tables/pages/quizIconButtonWidget.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';
import 'package:mult_tables/pages/reviewButtonWidget.dart';
import 'package:mult_tables/pages/tablePageWidget.dart';

class MultTablesHomePageWidget extends StatefulWidget {
  const MultTablesHomePageWidget({
    Key key,
  }) : super(key: key);

  @override
  _MultTablesHomePageWidgetState createState() =>
      _MultTablesHomePageWidgetState();
}

class _MultTablesHomePageWidgetState extends State<MultTablesHomePageWidget> {
  ScrollController _scrollController;
  bool _isOnTop = true;

  final dataKey = new GlobalKey();
  var items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    setState(() => _isOnTop = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBar(context, 'Multi Tables', QuizPageWidget(), dataKey),
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
                scrollToTop();
              },
            ),
            QuizIconButtonWidget(),
            ReviewButton(),
            AboutButton(),
          ]),

      body: Center(
          child: Container(
        color: Theme.of(context).primaryColor,
        child: GridView.extent(
          controller: _scrollController,
          maxCrossAxisExtent: 100,
          padding: const EdgeInsets.all(4),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: generateCells(99, context),
        ),
      )),
    );
  }

  List<Widget> generateCells(int count, BuildContext context) {
    return List.generate(count, (i) => generateCell(i, context));
  }

  InkWell generateCell(int i, BuildContext context) {
    var cellText = getCellText(i);
    return InkWell(
      child: CellWidget(cellText: cellText),
      onTap: () => tapAction(cellText, context),
    );
  }

  void tapAction(String cellText, BuildContext context) {
    print("Container pressed $cellText");
    int cellNo = int.parse(cellText);
    print(cellNo);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TablePageWidget(cellNo)),
    );
  }

  String getCellText(int i) => (i + 2).toString();
}

