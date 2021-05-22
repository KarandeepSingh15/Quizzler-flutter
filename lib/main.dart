import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Quizpage(),
        )),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scorekeeper = [];
  void checkanswer(bool userans) {
    bool correctanswer = quizBrain.getans();
    setState(() {
      if (quizBrain.isfinish()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "FINISHED!",
          desc: "Quiz is Finished.",
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  scorekeeper.clear();
                  quizBrain.resetqno();
                });

                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      } else if (userans == correctanswer)
        scorekeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      else
        scorekeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));

      quizBrain.getnextques();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getques(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {
              checkanswer(true);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'True',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {
              checkanswer(false);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'False',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        )),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
