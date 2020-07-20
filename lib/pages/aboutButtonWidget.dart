import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
        'Math App \nAn application to learn multiplication and to test your knowledge with a quiz';

    String email = 'mailto:mathapp@ammanath.com?subject=Feedback_about_mathapp';
    String thanks = '\nThanks for trying my app! ';
    String signature = '\n\n- Brijesh';
    String version = '\n- v1.3';
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text("About this app",
                    style: GoogleFonts.amarante(
                        fontSize: 26, color: Colors.black54))),
            content: Text.rich(
              TextSpan(
                text: textAbout[0],
                style:
                    GoogleFonts.rumRaisin(color: Colors.black54, fontSize: 22),
                children: [
                  TextSpan(
                      text: textAbout.substring(1),
                      style: GoogleFonts.rumRaisin(
                          fontSize: 14, color: Colors.black54)),
                  TextSpan(
                      text: thanks,
                      style: GoogleFonts.rumRaisin(
                          fontSize: 14, color: Colors.black54)),
                  TextSpan(
                      text: signature,
                      style: GoogleFonts.dancingScript(
                          fontSize: 20, color: Colors.blue)),
                ],
              ),
            ),
            elevation: 24.0,
            backgroundColor: Colors.blue[100],
            actions: <Widget>[
              Text(version,
                  style: GoogleFonts.dancingScript(
                      fontSize: 10, color: Colors.pink)),
              IconButton(
                icon: Icon(Icons.feedback),
                color: Colors.pink,
                alignment: Alignment.bottomLeft,
                tooltip: 'email',
                onPressed: () => _launchURL(email),
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
