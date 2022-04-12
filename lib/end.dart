import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndPage extends StatefulWidget {
  final int newScore;

  const EndPage({Key? key, required this.newScore}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  var highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  void _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = (prefs.getInt('highScore') ?? 0);
      if (widget.newScore > highScore) {
        prefs.setInt('highScore', widget.newScore);
      }
    });
  }

  String get resultPhrase {
    String phrase;
    if (widget.newScore > highScore) {
      phrase = 'New High Score!';
    } else {
      phrase = 'Your Total Score';
    }
    return phrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              resultPhrase,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.newScore.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                ),
              ),
              const Icon(Icons.star,
                  size: 64),
            ],
          ),
          const SizedBox(height: 45),
          ElevatedButton(
            onPressed: () {
              var count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
            },
            child: Text('Play Again ?'),
          ),
        ],
      ),
    );
  }
}
