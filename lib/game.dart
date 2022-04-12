import 'package:flutter/material.dart';
import './end.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var questionIndex = 0;
  var totalScore = 0;
  var correctAnswers = 0;
  var timeMultiplier = 0;
  final answerController = TextEditingController();

  final questions = const [
    {
      'display': '34 + 43',
      'answer': 77,
      'score': 600,
    },
    {
      'display': '77 + 33',
      'answer': 100,
      'score': 400,
    },
  ];

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void _processAnswer(answerController, score) {
    int answer = int.parse(answerController.text);

    if (answer == questions[questionIndex]['answer']) {
      totalScore +=
          (answer - timeMultiplier * 5) > 20 ? answer - timeMultiplier : 20;
      correctAnswers++;
    }

    setState(() {
      if (questionIndex + 1 >= questions.length) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EndPage(newScore: totalScore)));
      } else {
        questionIndex++;
      }
    });
  }

  void _adjustScoreByTime(int ticks) {
    timeMultiplier = ticks;
  }

  int _displayQuestionScore() {
    int score = int.parse(answerController.text);
    (score - timeMultiplier * 5) > 20 ? score - timeMultiplier : 20;
    return score;
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _adjustScoreByTime(timer.tick);
    });

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // #1 Top Display
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('X'),
            ),
            Column(
              children: [
                const Text(
                  'SCORE',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      totalScore.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      size: 32,
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                const Text(
                  'Question',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  questionIndex.toString() + '/' + questions.length.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 120),

        // #2 Question Display
        Text(
          questions[questionIndex]['display'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 64,
          ),
        ),

        // #3 Entry field
        Padding(
          padding: EdgeInsets.all(50),
          child: TextField(
            controller: answerController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter answer quick!',
              focusColor: Color(0xffffffff),
            ),
          ),
        ),

        // #4 Current Score and Submit
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _processAnswer(
                    answerController, questions[questionIndex]['score']);
                answerController.clear();
              },
              child: Icon(Icons.arrow_forward_outlined),
            )
          ],
        )
      ],
    ));
  }
}
