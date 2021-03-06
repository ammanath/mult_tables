import 'package:flutter/material.dart';
import 'package:mult_tables/pages/MathChoicesWidget.dart';
import 'package:mult_tables/pages/TableBodyWidget.dart';
import 'package:mult_tables/pages/appBarProvider.dart';

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
            buildAppBar(context, 'Multi Tables for $multBy', MathChoices()),
        body: Center(
          child: TableBodyWidget(multBy),
        ),
      ),
    );
  }
}


