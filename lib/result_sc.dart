import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/main.dart';
import 'package:quiz/quiz_screen.dart';
import 'package:quiz/thought_api.dart';
import 'dart:async';

import 'const/colors.dart';
import 'const/images.dart';
import 'const/text_style.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.resultScore, {Key? key}) : super(key: key);

  final int resultScore;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

//For displaying Results
class _ResultScreenState extends State<ResultScreen> {
  Quotes? data;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 20), (Timer t) => getQuotes());
  }

  get resultScore => widget.resultScore;

  String get resultPhrase {
    // int resultScore = widget.resultScore;
    String resultText;
    if (resultScore >= 160) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 120) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 80) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 20) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  Future<Null> getQuotes() async {
    data = await Api.getQuotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // getQuotes();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blue, darkBlue],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Image.asset(
                main1,
              ),
              const SizedBox(height: 20),
              headingText(color: lightgrey, size: 35, text: resultPhrase),
              normalText(
                  color: Colors.white,
                  size: 40,
                  text: 'Score: ' '$resultScore'),
              const SizedBox(height: 20),
              normalText(color: lightgrey, size: 18, text: "Thought: "),
              Text(
                '${data?.content ?? "Remember always that you not only have the right to be an individual, you have an obligation to be one."}',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontFamily: "quick_semi",
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: width - 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(
                        color: blue, size: 18, text: "Restart Quiz"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
