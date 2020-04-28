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
    
    return  Container(
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
    children: _buildGridTileList(99));
  }

  List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(
      color: Colors.lime[200],
      child: Center(child: Text((i+2).toString()))
      ));
}
