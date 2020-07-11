import 'package:flutter/material.dart';
import 'package:mult_tables/pages/GridWidget.dart';
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