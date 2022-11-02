import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_widget/quotes_widget.dart';

class Good_Quotes extends StatelessWidget {
  const Good_Quotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: QuotesWidget(
          width: 300,
          height: 200,
          quoteFontSize: 21,
          authorFontSize: 18,
        ),
      ),
    );
  }
}
