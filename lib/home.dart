import 'package:flutter/material.dart';
import './game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget headerText = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Math Cards!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 64,
          color: Colors.white,
        ),
      ),
    );

    Widget scoreText = const Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Text(
        'CURRENT HIGH SCORE',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );

    Widget scoreDisplay = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          highScore.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 64,
          ),
        ),
        const Icon(Icons.star,
        size: 64),
      ],
    );

    return Scaffold(
      //App Bar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headerText,
          const SizedBox(height: 128),
          scoreText,
          scoreDisplay,
          const SizedBox(height: 128),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GamePage()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                ),
                const Text('play now'),
                const Icon(Icons.arrow_right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
