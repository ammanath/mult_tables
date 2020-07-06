import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsCellWidget extends StatefulWidget {
  const ResultsCellWidget({
    Key key,
    @required this.multiplyFor,
    @required this.multiplier,
    @required this.result,
  }) : super(key: key);

  final int multiplyFor, multiplier, result;

  @override
  _ResultsCellWidgetState createState() => _ResultsCellWidgetState();
}

class _ResultsCellWidgetState extends State<ResultsCellWidget> {
  bool _change = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            color:
                _change ? Colors.cyan[200] : Theme.of(context).backgroundColor,
          ),
          //color: Theme.of(context).backgroundColor,
          child: Center(
              child: RichText(
                text: TextSpan(
                  text: '*',
                  style: _change
                      ? GoogleFonts.kalam(fontSize: 6, color: Colors.green)
                      : GoogleFonts.kalam(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.multiplier.toString()} = ',
                    ),
                    TextSpan(
                      text: widget.result.toString(),
                      style: _change
                          ? GoogleFonts.kalam(fontSize: 36, color: Colors.black)
                          : GoogleFonts.kalam(fontSize: 26, color: Colors.pink),
                    ),
                  ],
                ),
              ))),
      onTap: () => tapAction(
          widget.multiplyFor, widget.multiplier, widget.result, context),
    );
  }

  void tapAction(int multFor, int multBy, int result, BuildContext context) {
    print(
        "Container pressed multFor: $multFor , multBy: $multBy, result: $result");
    print(context.widget);
    setState(() {
      _change = !_change;
    });
  }
}
