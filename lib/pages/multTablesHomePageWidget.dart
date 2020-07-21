import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:mult_tables/pages/aboutButtonWidget.dart';
import 'package:mult_tables/pages/cellWidget.dart';
import 'package:mult_tables/pages/quizIconButtonWidget.dart';
import 'package:mult_tables/pages/reviewButtonWidget.dart';
import 'package:mult_tables/pages/tablePageWidget.dart';

const String testDevice = 'MobileMathId';

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

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Maths', 'Puzzle', 'Memory'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        //adUnitId: 'ca-app-pub-6888147562274579/9373520117',//Real
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',//Test
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        //adUnitId: 'ca-app-pub-6888147562274579/2010568245',//Real
        adUnitId: '	ca-app-pub-3940256099942544/1033173712',//Test
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    // FirebaseAdMob.instance
    //     .initialize(appId: 'ca-app-pub-6888147562274579~4828303279');
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();

    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // _bannerAd.dispose();
    // _interstitialAd.dispose();
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
                
                createInterstitialAd()
                  ..load()
                  ..show();
                  
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
