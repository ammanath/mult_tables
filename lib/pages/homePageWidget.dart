import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mult_tables/pages/cellWidget.dart';
import 'package:mult_tables/pages/quizLevelsPageWidget.dart';
import 'package:mult_tables/pages/tablePageWidget.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _scrollToTop() {
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
            style: GoogleFonts.spaceMono(fontSize: 26, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                _scrollToTop();
              },
            ),
            IconButton(
              icon: Icon(Icons.question_answer),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizLevelsPageWidget()),
                );
              },
            ),
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

class ReviewButton extends StatelessWidget {
  const ReviewButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.star),
      color: Colors.pink[200],
      onPressed: () {
        show(context);
      },
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.blue,
            ), // set your own image/icon widget
            title: "Enjoying the KK Advice app?",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            positiveComment: "I'm delighted! 😍😍😍", // optional
            negativeComment: "I'm so sad! 😭😭😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              LaunchReview.launch();
            },
          );
        });
  }
}

class AboutButton extends StatelessWidget {
  const AboutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      color: Colors.lime,
      onPressed: () {
        showAboutDialog(context);
      },
    );
  }

  void showAboutDialog(BuildContext context) {
    String textAbout =
        'Unsolicited app on KK\'s 68 bits of unsolicitied life advice \n';
    String url = 'https://kk.org/thetechnium/68-bits-of-unsolicited-advice/ ';
    String youTube = 'https://www.youtube.com/watch?v=Zz70rcguxwk';
    String email = 'mailto:kkapp@ammanath.com?subject=Feedback_about_kkapp';
    String thanks = '\nThanks for trying my app! ';
    String signature = '\n\n- Brijesh';
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text("About this app",
                    style: GoogleFonts.amarante(
                      fontSize: 26,
                      color: Colors.black54,
                    ))),
            content: Text.rich(
              TextSpan(
                text: textAbout[0],
                style: GoogleFonts.rumRaisin(
                  color: Colors.black54,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(
                    text: textAbout.substring(1),
                    style: GoogleFonts.rumRaisin(
                        fontSize: 14, color: Colors.black54),
                  ),
                  TextSpan(
                    text: thanks,
                    style: GoogleFonts.rumRaisin(
                        fontSize: 14, color: Colors.black54),
                  ),
                  TextSpan(
                    text: signature,
                    style: GoogleFonts.dancingScript(
                        fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
            ),
            elevation: 24.0,
            backgroundColor: Colors.blue[100],
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.open_in_browser),
                color: Colors.red,
                alignment: Alignment.bottomLeft,
                tooltip: 'Read in browser',
                onPressed: () => _launchURL(url),
              ),
              IconButton(
                icon: Icon(Icons.feedback),
                color: Colors.pink,
                alignment: Alignment.bottomLeft,
                tooltip: 'email',
                onPressed: () => _launchURL(email),
              ),
              IconButton(
                icon: Icon(Icons.videocam),
                color: Colors.green,
                alignment: Alignment.bottomLeft,
                tooltip: 'YouTube',
                onPressed: () => _launchURL(youTube),
              ),
              RaisedButton(
                child: Text('Ok',
                    style: GoogleFonts.amarante(
                      fontSize: 26,
                      color: Colors.black,
                    )),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.blue[100],
              ),
            ],
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
